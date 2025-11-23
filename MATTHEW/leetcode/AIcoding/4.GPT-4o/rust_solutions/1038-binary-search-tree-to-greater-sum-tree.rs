use crate::TreeNode;

struct Solution;

impl Solution {
    pub fn bst_to_gst(root: &mut Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
        let mut sum = 0;
        Self::convert_bst_to_gst(root.as_mut(), &mut sum);
        root.clone()
    }

    fn convert_bst_to_gst(node: Option<&mut Box<TreeNode>>, sum: &mut i32) {
        if let Some(n) = node {
            Self::convert_bst_to_gst(n.right.as_mut(), sum);
            *sum += n.val;
            n.val = *sum;
            Self::convert_bst_to_gst(n.left.as_mut(), sum);
        }
    }
}