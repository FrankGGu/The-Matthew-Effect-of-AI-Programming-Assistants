use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn evaluate_tree(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if let Some(node) = root {
            let node = node.borrow();
            match node.val {
                0 => false,
                1 => true,
                2 => Self::evaluate_tree(node.left.clone()) || Self::evaluate_tree(node.right.clone()),
                3 => Self::evaluate_tree(node.left.clone()) && Self::evaluate_tree(node.right.clone()),
                _ => false,
            }
        } else {
            false
        }
    }
}