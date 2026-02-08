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
    pub fn sum_root_to_leaf(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, current: i32) -> i32 {
            match node {
                Some(n) => {
                    let node = n.borrow();
                    let new_current = (current << 1) + node.val;
                    if node.left.is_none() && node.right.is_none() {
                        new_current
                    } else {
                        dfs(node.left.clone(), new_current) + dfs(node.right.clone(), new_current)
                    }
                }
                None => 0,
            }
        }

        dfs(root, 0)
    }
}

struct Solution;