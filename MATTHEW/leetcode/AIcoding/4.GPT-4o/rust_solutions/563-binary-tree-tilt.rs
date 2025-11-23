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

pub struct Solution;

impl Solution {
    pub fn find_tilt(root: Option<Box<TreeNode>>) -> i32 {
        let mut total_tilt = 0;

        fn dfs(node: Option<&Box<TreeNode>>, total_tilt: &mut i32) -> i32 {
            if let Some(n) = node {
                let left_sum = dfs(n.left.as_ref(), total_tilt);
                let right_sum = dfs(n.right.as_ref(), total_tilt);
                *total_tilt += (left_sum - right_sum).abs();
                return left_sum + right_sum + n.val;
            }
            0
        }

        dfs(root.as_ref(), &mut total_tilt);
        total_tilt
    }
}