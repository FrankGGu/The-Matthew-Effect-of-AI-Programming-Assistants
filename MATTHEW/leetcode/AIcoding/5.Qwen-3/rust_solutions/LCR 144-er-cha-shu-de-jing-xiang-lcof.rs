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

pub fn invert_tree(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    if let Some(mut node) = root {
        let left = node.left.take();
        let right = node.right.take();
        node.left = invert_tree(right);
        node.right = invert_tree(left);
        Some(node)
    } else {
        None
    }
}
}