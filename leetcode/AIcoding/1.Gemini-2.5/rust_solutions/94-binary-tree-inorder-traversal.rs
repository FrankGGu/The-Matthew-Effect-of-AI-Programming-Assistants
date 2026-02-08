use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn inorder_traversal(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut result = Vec::new();
        Self::inorder_helper(root, &mut result);
        result
    }

    fn inorder_helper(node: Option<Rc<RefCell<TreeNode>>>, result: &mut Vec<i32>) {
        if let Some(n) = node {
            let n_borrowed = n.borrow();
            Self::inorder_helper(n_borrowed.left.clone(), result);
            result.push(n_borrowed.val);
            Self::inorder_helper(n_borrowed.right.clone(), result);
        }
    }
}