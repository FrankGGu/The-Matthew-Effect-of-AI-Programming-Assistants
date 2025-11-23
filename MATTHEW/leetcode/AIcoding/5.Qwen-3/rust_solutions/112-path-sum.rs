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

pub fn has_path_sum(root: Option<Box<TreeNode>>, target_sum: i32) -> bool {
    match root {
        None => false,
        Some(node) => {
            if node.left.is_none() && node.right.is_none() {
                return node.val == target_sum;
            }
            has_path_sum(node.left, target_sum - node.val)
                || has_path_sum(node.right, target_sum - node.val)
        }
    }
}
}