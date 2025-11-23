impl Solution {

use std::cmp::max;
use std::collections::HashMap;

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

pub fn longest_increasing_path(root: Option<Box<TreeNode>>) -> i32 {
    if root.is_none() {
        return 0;
    }

    let mut memo = HashMap::new();
    let mut max_length = 0;

    fn dfs(node: &Box<TreeNode>, parent_val: i32, memo: &mut HashMap<*const TreeNode, i32>) -> i32 {
        let node_ptr = node as *const TreeNode;
        if let Some(&length) = memo.get(&node_ptr) {
            return length;
        }

        let mut max_len = 1;

        if let Some(left) = &node.left {
            if left.val > node.val {
                max_len = max(max_len, 1 + dfs(left, node.val, memo));
            }
        }

        if let Some(right) = &node.right {
            if right.val > node.val {
                max_len = max(max_len, 1 + dfs(right, node.val, memo));
            }
        }

        memo.insert(node_ptr, max_len);
        max_len
    }

    dfs(&root.unwrap(), i32::MIN, &mut memo);

    memo.values().copied().max().unwrap_or(0)
}
}