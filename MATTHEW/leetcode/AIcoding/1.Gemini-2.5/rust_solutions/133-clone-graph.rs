use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashMap;

impl Solution {
    pub fn clone_graph(node: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
        if node.is_none() {
            return None;
        }

        let mut visited: HashMap<i32, Rc<RefCell<Node>>> = HashMap::new();

        // Helper function for DFS traversal and cloning
        fn dfs_helper(
            original_node_opt: Option<Rc<RefCell<Node>>>,
            visited: &mut HashMap<i32, Rc<RefCell<Node>>>,
        ) -> Option<Rc<RefCell<Node>>> {
            let original_node_rc = match original_node_opt {
                Some(rc) => rc,
                None => return None,
            };

            let original_node = original_node_rc.borrow();
            let val = original_node.val;

            // If the node has already been visited, return its clone from the map
            if let Some(cloned_node_rc) = visited.get(&val) {
                return Some(Rc::clone(cloned_node_rc));
            }

            // Create a new cloned node
            let new_node_rc = Rc::new(RefCell::new(Node::new(val)));
            // Add the new cloned node to the visited map before processing neighbors
            // to handle cycles correctly
            visited.insert(val, Rc::clone(&new_node_rc));

            // Recursively clone neighbors
            let mut new_neighbors = Vec::new();
            for neighbor_opt in &original_node.neighbors {
                // `neighbor_opt.clone()` creates a new `Option<Rc<RefCell<Node>>>`
                // for the recursive call, incrementing the reference count for the `Rc` if it's `Some`.
                if let Some(cloned_neighbor_rc) = dfs_helper(neighbor_opt.clone(), visited) {
                    new_neighbors.push(Some(cloned_neighbor_rc));
                } else {
                    // If an original neighbor was None, the cloned neighbor should also be None
                    new_neighbors.push(None);
                }
            }
            new_node_rc.borrow_mut().neighbors = new_neighbors;

            Some(new_node_rc)
        }

        dfs_helper(node, &mut visited)
    }
}