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

pub struct Solution {
    longest: i32,
}

impl Solution {
    pub fn longest_univalue_path(root: Option<Box<TreeNode>>) -> i32 {
        let mut solution = Solution { longest: 0 };
        solution.dfs(&root);
        solution.longest
    }

    fn dfs(&mut self, node: &Option<Box<TreeNode>>) -> i32 {
        if let Some(n) = node {
            let left_length = self.dfs(&n.left);
            let right_length = self.dfs(&n.right);
            let mut left = 0;
            let mut right = 0;

            if let Some(left_node) = &n.left {
                if left_node.val == n.val {
                    left = left_length + 1;
                }
            }
            if let Some(right_node) = &n.right {
                if right_node.val == n.val {
                    right = right_length + 1;
                }
            }

            self.longest = self.longest.max(left + right);
            left.max(right)
        } else {
            0
        }
    }
}