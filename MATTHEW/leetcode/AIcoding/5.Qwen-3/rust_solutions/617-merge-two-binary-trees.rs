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

pub fn merge_trees(
    root1: Option<Box<TreeNode>>,
    root2: Option<Box<TreeNode>>,
) -> Option<Box<TreeNode>> {
    match (root1, root2) {
        (Some(n1), Some(n2)) => {
            let val = n1.val + n2.val;
            let left = merge_trees(n1.left, n2.left);
            let right = merge_trees(n1.right, n2.right);
            Some(Box::new(TreeNode { val, left, right }))
        }
        (Some(n), None) => Some(n),
        (None, Some(n)) => Some(n),
        (None, None) => None,
    }
}
}