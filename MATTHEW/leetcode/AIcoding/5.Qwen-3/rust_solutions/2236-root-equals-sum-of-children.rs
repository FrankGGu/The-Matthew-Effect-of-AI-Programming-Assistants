impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn root_equals_subtree_sum(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
    fn helper(node: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
        match node {
            Some(n) => {
                let n_ref = n.borrow();
                let left_sum = helper(&n_ref.left);
                let right_sum = helper(&n_ref.right);
                left_sum + right_sum
            }
            None => 0,
        }
    }

    if let Some(n) = root {
        let n_ref = n.borrow();
        helper(&n_ref.left) + helper(&n_ref.right) == n_ref.val
    } else {
        false
    }
}
}