use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn prune_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(node) = root {
            let mut node_borrow = node.borrow_mut();

            node_borrow.left = Self::prune_tree(node_borrow.left.take());
            node_borrow.right = Self::prune_tree(node_borrow.right.take());

            if node_borrow.val == 0 && node_borrow.left.is_none() && node_borrow.right.is_none() {
                None
            } else {
                Some(node.clone())
            }
        } else {
            None
        }
    }
}