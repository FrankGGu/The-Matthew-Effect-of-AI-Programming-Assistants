#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
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
        node.left = invert_tree(node.right.take());
        node.right = invert_tree(left);
        Some(node)
    } else {
        None
    }
}