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
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub struct Solution {}

impl Solution {
    pub fn max_path_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_sum = i32::MIN;

        fn find_max_path(node: Option<&Rc<RefCell<TreeNode>>>, max_sum: &mut i32) -> i32 {
            if let Some(n) = node {
                let n = n.borrow();
                let left_sum = find_max_path(n.left.as_ref(), max_sum);
                let right_sum = find_max_path(n.right.as_ref(), max_sum);
                let current_max = n.val + left_sum.max(0) + right_sum.max(0);
                *max_sum = (*max_sum).max(current_max);
                n.val + left_sum.max(right_sum).max(0)
            } else {
                0
            }
        }

        find_max_path(root.as_ref(), &mut max_sum);
        max_sum
    }
}