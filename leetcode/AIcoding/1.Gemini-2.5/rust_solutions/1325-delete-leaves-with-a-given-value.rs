use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn remove_leaf_nodes(root: Option<Rc<RefCell<TreeNode>>>, target: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if root.is_none() {
            return None;
        }

        let node_rc = root.unwrap();
        let mut node_borrow = node_rc.borrow_mut();

        node_borrow.left = Self::remove_leaf_nodes(node_borrow.left.take(), target);
        node_borrow.right = Self::remove_leaf_nodes(node_borrow.right.take(), target);

        if node_borrow.left.is_none() && node_borrow.right.is_none() && node_borrow.val == target {
            drop(node_borrow); // Explicitly drop the RefMut to release the borrow before `node_rc` is potentially dropped.
            None
        } else {
            drop(node_borrow); // Explicitly drop the RefMut to release the borrow before `node_rc` is returned.
            Some(node_rc)
        }
    }
}