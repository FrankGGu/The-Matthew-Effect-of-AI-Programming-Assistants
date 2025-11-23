use crate::TreeNode;

impl Solution {
    pub fn max_path_sum(root: Option<Box<TreeNode>>) -> i32 {
        let mut max_sum = i32::MIN;
        Self::max_gain(&root, &mut max_sum);
        max_sum
    }

    fn max_gain(node: &Option<Box<TreeNode>>, max_sum: &mut i32) -> i32 {
        if let Some(n) = node {
            let left_gain = Self::max_gain(&n.left, max_sum).max(0);
            let right_gain = Self::max_gain(&n.right, max_sum).max(0);
            let price_newpath = n.val + left_gain + right_gain;

            *max_sum = (*max_sum).max(price_newpath);
            n.val + left_gain.max(right_gain)
        } else {
            0
        }
    }
}