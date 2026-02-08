use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn is_unival_tree(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if root.is_none() {
            return true;
        }

        let root_val = root.as_ref().unwrap().borrow().val;
        Self::check_unival(root, root_val)
    }

    fn check_unival(node: Option<Rc<RefCell<TreeNode>>>, expected_val: i32) -> bool {
        if node.is_none() {
            return true;
        }

        let current_node = node.as_ref().unwrap().borrow();
        if current_node.val != expected_val {
            return false;
        }

        Self::check_unival(current_node.left.clone(), expected_val) &&
        Self::check_unival(current_node.right.clone(), expected_val)
    }
}