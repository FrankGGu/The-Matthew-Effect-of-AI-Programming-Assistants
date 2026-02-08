use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn prune_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(node) = root {
            let mut node_ref = node.borrow_mut();
            let left = Self::prune_tree(node_ref.left.take());
            let right = Self::prune_tree(node_ref.right.take());
            if left.is_none() && right.is_none() && node_ref.val == 0 {
                return None;
            }
            node_ref.left = left;
            node_ref.right = right;
            drop(node_ref);
            Some(node)
        } else {
            None
        }
    }
}