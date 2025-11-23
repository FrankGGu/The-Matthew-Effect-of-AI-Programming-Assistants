use crate::TreeNode;

pub struct Solution;

impl Solution {
    pub fn convert_bst(root: &mut Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
        let mut sum = 0;
        Self::traverse(root.as_mut(), &mut sum);
        root.clone()
    }

    fn traverse(node: Option<&mut Box<TreeNode>>, sum: &mut i32) {
        if let Some(n) = node {
            Self::traverse(n.right.as_mut(), sum);
            *sum += n.val;
            n.val = *sum;
            Self::traverse(n.left.as_mut(), sum);
        }
    }
}