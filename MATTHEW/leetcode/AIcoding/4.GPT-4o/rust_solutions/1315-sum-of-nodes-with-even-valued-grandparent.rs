use crate::TreeNode;

impl Solution {
    pub fn sum_even_grandparent(root: Option<Box<TreeNode>>) -> i32 {
        fn dfs(node: Option<&Box<TreeNode>>, parent: i32, grandparent: i32) -> i32 {
            if let Some(n) = node {
                let mut sum = 0;
                if grandparent % 2 == 0 {
                    sum += n.val;
                }
                sum += dfs(n.left.as_ref(), n.val, parent) + dfs(n.right.as_ref(), n.val, parent);
                sum
            } else {
                0
            }
        }
        dfs(root.as_ref(), 1, 1)
    }
}