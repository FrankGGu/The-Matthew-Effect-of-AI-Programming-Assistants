use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn find_second_minimum_value(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, min1: i32) -> Option<i32> {
            if let Some(n) = node {
                let val = n.borrow().val;
                if val > min1 {
                    return Some(val);
                } else {
                    let left = dfs(n.borrow().left.clone(), min1);
                    let right = dfs(n.borrow().right.clone(), min1);

                    match (left, right) {
                        (Some(l), Some(r)) => Some(l.min(r)),
                        (Some(l), None) => Some(l),
                        (None, Some(r)) => Some(r),
                        (None, None) => None,
                    }
                }
            } else {
                None
            }
        }

        if let Some(r) = root {
            match dfs(Some(r.clone()), r.borrow().val) {
                Some(val) => val,
                None => -1,
            }
        } else {
            -1
        }
    }
}

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

struct Solution;