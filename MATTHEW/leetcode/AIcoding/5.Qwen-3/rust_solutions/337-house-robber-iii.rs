impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

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

pub fn rob(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn helper(node: &Option<Rc<RefCell<TreeNode>>>) -> (i32, i32) {
        if let Some(n) = node {
            let left = helper(&n.borrow().left);
            let right = helper(&n.borrow().right);
            let take = n.borrow().val + left.1 + right.1;
            let skip = left.0.max(left.1) + right.0.max(right.1);
            (take, skip)
        } else {
            (0, 0)
        }
    }

    let result = helper(&root);
    result.0.max(result.1)
}
}