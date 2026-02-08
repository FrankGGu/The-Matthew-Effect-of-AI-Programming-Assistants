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
    pub fn is_valid_bst(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        fn helper(node: Option<Rc<RefCell<TreeNode>>>, min: Option<i64>, max: Option<i64>) -> bool {
            match node {
                None => true,
                Some(n) => {
                    let n = n.borrow();
                    let val = n.val as i64;

                    if let Some(min_val) = min {
                        if val <= min_val {
                            return false;
                        }
                    }

                    if let Some(max_val) = max {
                        if val >= max_val {
                            return false;
                        }
                    }

                    helper(n.left.clone(), min, Some(val)) && helper(n.right.clone(), Some(val), max)
                }
            }
        }

        helper(root, None, None)
    }
}

struct Solution;