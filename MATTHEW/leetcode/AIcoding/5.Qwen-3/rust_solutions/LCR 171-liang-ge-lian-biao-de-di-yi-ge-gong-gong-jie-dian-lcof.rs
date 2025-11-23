impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
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

use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn is_sub_structure(a: Option<Box<TreeNode>>, b: Option<Box<TreeNode>>) -> bool {
        fn dfs(a: &Option<Box<TreeNode>>, b: &Option<Box<TreeNode>>) -> bool {
            match (a, b) {
                (Some(a_node), Some(b_node)) => {
                    a_node.val == b_node.val
                        && dfs(&a_node.left, &b_node.left)
                        && dfs(&a_node.right, &b_node.right)
                }
                (None, Some(_)) => false,
                _ => true,
            }
        }

        match (a, b) {
            (Some(a_node), Some(b_node)) => {
                dfs(&Some(a_node.clone()), &Some(b_node.clone()))
                    || Solution::is_sub_structure(a_node.left, Some(b_node.clone()))
                    || Solution::is_sub_structure(a_node.right, Some(b_node.clone()))
            }
            _ => false,
        }
    }
}
}