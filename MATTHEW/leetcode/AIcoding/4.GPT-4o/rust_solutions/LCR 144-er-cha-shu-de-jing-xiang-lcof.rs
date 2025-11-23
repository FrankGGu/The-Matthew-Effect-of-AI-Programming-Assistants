#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn invert_tree(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
        if let Some(mut node) = root {
            let left = node.left.take();
            node.left = Self::invert_tree(node.right.take());
            node.right = Self::invert_tree(left);
            Some(node)
        } else {
            None
        }
    }
}