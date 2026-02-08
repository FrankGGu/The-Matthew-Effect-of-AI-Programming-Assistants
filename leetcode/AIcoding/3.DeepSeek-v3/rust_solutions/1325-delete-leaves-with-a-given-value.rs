use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn remove_leaf_nodes(root: Option<Rc<RefCell<TreeNode>>>, target: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(node) = root {
            let mut node_ref = node.borrow_mut();
            let left = Self::remove_leaf_nodes(node_ref.left.take(), target);
            let right = Self::remove_leaf_nodes(node_ref.right.take(), target);
            node_ref.left = left;
            node_ref.right = right;
            if node_ref.left.is_none() && node_ref.right.is_none() && node_ref.val == target {
                return None;
            }
            drop(node_ref);
            Some(node)
        } else {
            None
        }
    }
}