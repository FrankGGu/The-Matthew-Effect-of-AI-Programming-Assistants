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

pub fn max_diff_node_ancestor(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn dfs(node: &Rc<RefCell<TreeNode>>, min_val: i32) -> i32 {
        let current = node.borrow();
        let current_val = current.val;
        let mut max_diff = 0;

        if let Some(left) = &current.left {
            max_diff = std::cmp::max(max_diff, dfs(left, std::cmp::min(min_val, current_val)));
        }

        if let Some(right) = &current.right {
            max_diff = std::cmp::max(max_diff, dfs(right, std::cmp::min(min_val, current_val)));
        }

        std::cmp::max(max_diff, current_val - min_val)
    }

    match root {
        Some(node) => dfs(&node, node.borrow().val),
        None => 0,
    }
}
}