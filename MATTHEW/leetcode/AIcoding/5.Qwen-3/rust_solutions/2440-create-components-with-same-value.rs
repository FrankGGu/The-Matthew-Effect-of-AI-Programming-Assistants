impl Solution {

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

pub fn equal_tree_partition(root: Option<Box<TreeNode>>) -> bool {
    fn post_order(node: &Option<Box<TreeNode>>, map: &mut HashMap<i32, i32>) -> i32 {
        if let Some(n) = node {
            let left_sum = post_order(&n.left, map);
            let right_sum = post_order(&n.right, map);
            let total = n.val + left_sum + right_sum;
            *map.entry(total).or_insert(0) += 1;
            total
        } else {
            0
        }
    }

    let total_sum = post_order(&root, &mut HashMap::new());
    if total_sum == 0 {
        return false;
    }

    for (&sum, &count) in &map {
        if sum * 2 == total_sum && count > 1 {
            return true;
        }
    }

    false
}
}