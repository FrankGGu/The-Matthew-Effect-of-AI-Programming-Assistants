use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn evaluate_tree(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        let node = root.unwrap();
        let borrowed_node = node.borrow();

        match borrowed_node.val {
            0 => false,
            1 => true,
            2 => { // OR operation
                let left_result = Self::evaluate_tree(borrowed_node.left.clone());
                let right_result = Self::evaluate_tree(borrowed_node.right.clone());
                left_result || right_result
            },
            3 => { // AND operation
                let left_result = Self::evaluate_tree(borrowed_node.left.clone());
                let right_result = Self::evaluate_tree(borrowed_node.right.clone());
                left_result && right_result
            },
            _ => unreachable!(), // According to problem constraints, val will be 0, 1, 2, or 3.
        }
    }
}