#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
  pub val: i32,
  pub left: Option<Rc<RefCell<TreeNode>>>,
  pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
  #[inline]
  pub fn new(val: i32) -> Self {
    TreeNode {
      val,
      left: None,
      right: None
    }
  }
}
use std::rc::Rc;
use std::cell::RefCell;
use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn can_merge(trees: Vec<Option<Rc<RefCell<TreeNode>>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if trees.is_empty() {
            return None;
        }

        let mut tree_map: HashMap<i32, Rc<RefCell<TreeNode>>> = HashMap::new();
        let mut all_node_values: HashSet<i32> = HashSet::new();
        let mut child_values: HashSet<i32> = HashSet::new();

        for tree_opt in trees {
            if let Some(tree_rc) = tree_opt {
                let root_val = tree_rc.borrow().val;
                tree_map.insert(root_val, tree_rc.clone());

                if !Self::collect_nodes(Some(tree_rc), &mut all_node_values, &mut child_values) {
                    return None; // Duplicate value found in input trees
                }
            }
        }

        let mut final_root_val_opt: Option<i32> = None;
        for (&root_val, _) in tree_map.iter() {
            if !child_values.contains(&root_val) {
                if final_root_val_opt.is_some() {
                    return None; // More than one candidate for the final root
                }
                final_root_val_opt = Some(root_val);
            }
        }

        let final_root_val = match final_root_val_opt {
            Some(val) => val,
            None => return None, // No final root found
        };

        let final_root_tree = tree_map.remove(&final_root_val).unwrap();

        let mut visited_nodes: HashSet<i32> = HashSet::new();
        if !Self::merge_and_validate(Some(final_root_tree.clone()), &mut tree_map, &mut visited_nodes, i32::MIN, i32::MAX) {
            return None; // Invalid merge or BST property violation
        }

        if !tree_map.is_empty() || visited_nodes.len() != all_node_values.len() {
            return None; // Not all trees merged or not all nodes present in the final tree
        }

        Some(final_root_tree)
    }

    fn collect_nodes(
        node_opt: Option<Rc<RefCell<TreeNode>>>,
        all_node_values: &mut HashSet<i32>,
        child_values: &mut HashSet<i32>,
    ) -> bool {
        if let Some(node_rc) = node_opt {
            let val = node_rc.borrow().val;
            if !all_node_values.insert(val) {
                return false; // Duplicate value found across input trees
            }

            let left_child_opt = node_rc.borrow().left.clone();
            if left_child_opt.is_some() {
                child_values.insert(left_child_opt.as_ref().unwrap().borrow().val);
                if !Self::collect_nodes(left_child_opt, all_node_values, child_values) {
                    return false;
                }
            }

            let right_child_opt = node_rc.borrow().right.clone();
            if right_child_opt.is_some() {
                child_values.insert(right_child_opt.as_ref().unwrap().borrow().val);
                if !Self::collect_nodes(right_child_opt, all_node_values, child_values) {
                    return false;
                }
            }
        }
        true
    }

    fn merge_and_validate(
        node_opt: Option<Rc<RefCell<TreeNode>>>,
        tree_map: &mut HashMap<i32, Rc<RefCell<TreeNode>>>,
        visited_nodes: &mut HashSet<i32>,
        min_val: i32,
        max_val: i32,
    ) -> bool {
        if let Some(node_rc) = node_opt {
            let val = node_rc.borrow().val;

            if val <= min_val || val >= max_val {
                return false; // BST property violation
            }
            if !visited_nodes.insert(val) {
                return false; // Duplicate node in the merged tree (cycle or invalid merge)
            }

            let mut node = node_rc.borrow_mut();

            // Handle left child
            let current_left_child_opt = node.left.take(); // Take ownership to modify
            if let Some(left_child_rc) = current_left_child_opt {
                let left_child_val = left_child_rc.borrow().val;
                if tree_map.contains_key(&left_child_val) {
                    // This child's value is a root of another unmerged tree, replace it
                    node.left = tree_map.remove(&left_child_val);
                    if !Self::merge_and_validate(node.left.clone(), tree_map, visited_nodes, min_val, val) {
                        return false;
                    }
                } else {
                    // This child is a normal node within the current tree, put it back
                    node.left = Some(left_child_rc);
                    if !Self::merge_and_validate(node.left.clone(), tree_map, visited_nodes, min_val, val) {
                        return false;
                    }
                }
            }
            // If node.left was None, it remains None. No merge happens here.

            // Handle right child
            let current_right_child_opt = node.right.take(); // Take ownership to modify
            if let Some(right_child_rc) = current_right_child_opt {
                let right_child_val = right_child_rc.borrow().val;
                if tree_map.contains_key(&right_child_val) {
                    // This child's value is a root of another unmerged tree, replace it
                    node.right = tree_map.remove(&right_child_val);
                    if !Self::merge_and_validate(node.right.clone(), tree_map, visited_nodes, val, max_val) {
                        return false;
                    }
                } else {
                    // This child is a normal node within the current tree, put it back
                    node.right = Some(right_child_rc);
                    if !Self::merge_and_validate(node.right.clone(), tree_map, visited_nodes, val, max_val) {
                        return false;
                    }
                }
            }
            // If node.right was None, it remains None.
        }
        true
    }
}