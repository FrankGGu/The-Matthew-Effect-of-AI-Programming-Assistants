use std::collections::{BTreeMap, HashMap, HashSet};
use std::rc::Rc;
use std::cell::RefCell;

struct FolderNode {
    id: usize,
    name: String,
    children: BTreeMap<String, Rc<RefCell<FolderNode>>>,
}

impl FolderNode {
    fn new(name: String, id_counter: &mut usize) -> Rc<RefCell<Self>> {
        let id = *id_counter;
        *id_counter += 1;
        Rc::new(RefCell::new(FolderNode {
            id,
            name,
            children: BTreeMap::new(),
        }))
    }
}

fn compute_signatures_and_mark_duplicates(
    node_rc: Rc<RefCell<FolderNode>>,
    current_depth: usize,
    signature_map: &mut HashMap<String, (usize, usize, Rc<RefCell<FolderNode>>)>, // sig -> (id, depth, Rc) of node to keep
    deletion_set: &mut HashSet<usize>, // IDs of nodes to be deleted
) -> Option<String> {
    let node_id = node_rc.borrow().id;

    // If this node or an ancestor has already been marked for deletion, skip processing this branch.
    if deletion_set.contains(&node_id) {
        return None;
    }

    // Recursively process children first (post-order traversal)
    let mut child_signatures_and_names: Vec<(String, String)> = Vec::new(); // (child_name, child_signature)
    let mut child_rcs = Vec::new();
    for (child_name, child_rc) in node_rc.borrow().children.iter() {
        child_rcs.push((child_name.clone(), Rc::clone(child_rc)));
    }

    for (child_name, child_rc) in child_rcs {
        if let Some(child_signature) = compute_signatures_and_mark_duplicates(
            child_rc,
            current_depth + 1,
            signature_map,
            deletion_set,
        ) {
            // Only include children that were NOT marked for deletion in the parent's signature
            child_signatures_and_names.push((child_name, child_signature));
        }
    }

    // Sort children by name for canonical signature
    child_signatures_and_names.sort_by(|a, b| a.0.cmp(&b.0));

    // Construct the current node's signature based on its children's names and signatures.
    // The problem implies "same set of subfolders, and their subfolders are also duplicates".
    // This typically means the signature does NOT include the current node's own name.
    let mut signature_parts: Vec<String> = Vec::new();
    for (child_name, child_signature) in child_signatures_and_names {
        signature_parts.push(format!("{}({})", child_name, child_signature));
    }
    let current_node_signature = signature_parts.join("");

    // If this is the dummy root, we don't consider it for deletion or add its signature to the map.
    if node_rc.borrow().name.is_empty() {
        return Some(current_node_signature);
    }

    // Check for duplicates based on current_node_signature
    if let Some((existing_id, existing_depth, existing_rc)) = signature_map.get(&current_node_signature) {
        // Duplicate found. Apply "keep one, delete others" rule.
        // The one with the smallest depth is kept. If depths are equal, the one with smaller ID is kept.
        let mut to_delete_id = node_id; // Assume current node is to be deleted
        let mut to_keep_id = *existing_id;
        let mut to_keep_rc = Rc::clone(existing_rc);

        if current_depth < *existing_depth {
            // Current node is closer to root, keep current, delete existing
            to_delete_id = *existing_id;
            to_keep_id = node_id;
            to_keep_rc = Rc::clone(&node_rc);
        } else if current_depth == *existing_depth {
            // Same depth, keep the one with smaller ID
            if node_id < *existing_id {
                to_delete_id = *existing_id;
                to_keep_id = node_id;
                to_keep_rc = Rc::clone(&node_rc);
            }
            // else: to_delete_id is already node_id, to_keep_id is existing_id
        }
        // else (current_depth > existing_depth): to_delete_id is already node_id, to_keep_id is existing_id

        deletion_set.insert(to_delete_id);

        // If the existing node was deleted, update the map to point to the new "kept" node
        if to_delete_id == *existing_id {
            signature_map.insert(current_node_signature.clone(), (to_keep_id, current_depth, to_keep_rc));
        }
    } else {
        // First time seeing this signature, add to map as the one to keep
        signature_map.insert(current_node_signature.clone(), (node_id, current_depth, Rc::clone(&node_rc)));
    }

    // If the current node itself was marked for deletion, return None.
    // Otherwise, return its signature.
    if deletion_set.contains(&node_id) {
        None
    } else {
        Some(current_node_signature)
    }
}

fn collect_paths_dfs_final(
    node_rc: Rc<RefCell<FolderNode>>,
    current_path: &mut Vec<String>,
    result_paths: &mut Vec<Vec<String>>,
    deletion_set: &HashSet<usize>,
) {
    let node = node_rc.borrow();

    // If this node is marked for deletion, stop traversing this branch.
    if deletion_set.contains(&node.id) {
        return;
    }

    // Add current node's path to results (if it's not the dummy root)
    if !node.name.is_empty() {
        current_path.push(node.name.clone());
        result_paths.push(current_path.clone());
    }

    // Traverse children that are not marked for deletion
    for (_, child_rc) in node.children.iter() {
        collect_paths_dfs_final(Rc::clone(child_rc), current_path, result_paths, deletion_set);
    }

    // Backtrack
    if !node.name.is_empty() {
        current_path.pop();
    }
}

impl Solution {
    pub fn delete_duplicate_folders(paths: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut id_counter = 0;
        let root = FolderNode::new("".to_string(), &mut id_counter); // Dummy root

        // Build the tree
        for path in paths {
            let mut current_node_rc = Rc::clone(&root);
            for name in path {
                let next_node_rc = {
                    let mut current_node = current_node_rc.borrow_mut();
                    current_node.children.entry(name.clone())
                                .or_insert_with(|| FolderNode::new(name, &mut id_counter))
                                .clone() // Clone the Rc to drop the borrow on current_node_rc
                };
                current_node_rc = next_node_rc;
            }
        }

        let mut signature_map: HashMap<String, (usize, usize, Rc<RefCell<FolderNode>>)> = HashMap::new();
        let mut deletion_set: HashSet<usize> = HashSet::new();

        // Compute signatures and identify duplicates (post-order DFS)
        // Start from the dummy root, depth 0.
        compute_signatures_and_mark_duplicates(Rc::clone(&root), 0, &mut signature_map, &mut deletion_set);

        // Collect paths of remaining folders (pre-order DFS)
        let mut result_paths: Vec<Vec<String>> = Vec::new();
        let mut current_path: Vec<String> = Vec::new();
        collect_paths_dfs_final(Rc::clone(&root), &mut current_path, &mut result_paths, &deletion_set);

        result_paths
    }
}