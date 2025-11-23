#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn min_depth(root: Option<Box<TreeNode>>) -> i32 {
        if root.is_none() {
            return 0;
        }
        let node = root.as_ref().unwrap();
        if node.left.is_none() && node.right.is_none() {
            return 1;
        }
        let left_depth = if node.left.is_some() {
            Self::min_depth(node.left.clone())
        } else {
            i32::MAX
        };
        let right_depth = if node.right.is_some() {
            Self::min_depth(node.right.clone())
        } else {
            i32::MAX
        };
        1 + left_depth.min(right_depth)
    }
}