#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn trim_bst(root: Option<Box<TreeNode>>, low: i32, high: i32) -> Option<Box<TreeNode>> {
        if let Some(node) = root {
            if node.val < low {
                return Self::trim_bst(node.right, low, high);
            } else if node.val > high {
                return Self::trim_bst(node.left, low, high);
            }
            let left_trimmed = Self::trim_bst(node.left, low, high);
            let right_trimmed = Self::trim_bst(node.right, low, high);
            Some(Box::new(TreeNode {
                val: node.val,
                left: left_trimmed,
                right: right_trimmed,
            }))
        } else {
            None
        }
    }
}