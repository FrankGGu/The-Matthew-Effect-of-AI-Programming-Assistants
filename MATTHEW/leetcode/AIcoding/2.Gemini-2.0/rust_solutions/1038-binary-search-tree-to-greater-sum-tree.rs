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

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn bst_to_gst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut sum = 0;
        Solution::helper(&root, &mut sum);
        root
    }

    fn helper(node: &Option<Rc<RefCell<TreeNode>>>, sum: &mut i32) {
        if let Some(n) = node {
            Solution::helper(&n.borrow().right, sum);
            *sum += n.borrow().val;
            n.borrow_mut().val = *sum;
            Solution::helper(&n.borrow().left, sum);
        }
    }
}

struct Solution;