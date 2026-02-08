use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn invert_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(node_rc) = root.clone() {
            let mut node = node_rc.borrow_mut();

            let inverted_left = Self::invert_tree(node.right.take());
            let inverted_right = Self::invert_tree(node.left.take());

            node.left = inverted_left;
            node.right = inverted_right;
        }
        root
    }
}