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
    pub fn sum_of_left_leaves(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(root: Option<Rc<RefCell<TreeNode>>>, is_left: bool) -> i32 {
            match root {
                Some(node) => {
                    let node = node.borrow();
                    if node.left.is_none() && node.right.is_none() && is_left {
                        node.val
                    } else {
                        dfs(node.left.clone(), true) + dfs(node.right.clone(), false)
                    }
                }
                None => 0,
            }
        }

        dfs(root, false)
    }
}

struct Solution;