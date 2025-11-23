use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn invert_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(node_rc) = root.clone() {
            let mut node = node_rc.borrow_mut();

            let left_inverted = Self::invert_tree(node.left.take());
            let right_inverted = Self::invert_tree(node.right.take());

            node.left = right_inverted;
            node.right = left_inverted;

            root
        } else {
            None
        }
    }
}