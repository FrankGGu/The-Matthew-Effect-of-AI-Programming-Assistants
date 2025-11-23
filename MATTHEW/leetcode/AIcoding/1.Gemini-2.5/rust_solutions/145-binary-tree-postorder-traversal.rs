use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn postorder_traversal(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut result = Vec::new();
        Self::traverse(&root, &mut result);
        result
    }

    fn traverse(node: &Option<Rc<RefCell<TreeNode>>>, result: &mut Vec<i32>) {
        if let Some(n) = node {
            let n_borrow = n.borrow();
            Self::traverse(&n_borrow.left, result);
            Self::traverse(&n_borrow.right, result);
            result.push(n_borrow.val);
        }
    }
}