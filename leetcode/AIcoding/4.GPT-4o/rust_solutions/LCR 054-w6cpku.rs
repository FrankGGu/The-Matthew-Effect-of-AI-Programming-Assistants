use crate::TreeNode;

pub struct Solution;

impl Solution {
    pub fn convert_bst(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
        let mut sum = 0;
        Self::convert(&mut sum, root)
    }

    fn convert(sum: &mut i32, node: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
        if let Some(mut n) = node {
            if let Some(right) = Self::convert(sum, n.right) {
                n.right = Some(right);
            }
            *sum += n.val;
            n.val = *sum;
            if let Some(left) = Self::convert(sum, n.left) {
                n.left = Some(left);
            }
            Some(n)
        } else {
            None
        }
    }
}