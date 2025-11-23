use crate::TreeNode;

impl Solution {
    pub fn sufficient_subset(root: Option<Box<TreeNode>>, limit: i32) -> Option<Box<TreeNode>> {
        fn dfs(node: Option<Box<TreeNode>>, sum: i32, limit: i32) -> (Option<Box<TreeNode>>, i32) {
            if let Some(n) = node {
                let new_sum = sum + n.val;
                if n.left.is_none() && n.right.is_none() {
                    return if new_sum < limit {
                        (None, new_sum)
                    } else {
                        (Some(n), new_sum)
                    };
                }
                let (left, left_sum) = dfs(n.left, new_sum, limit);
                let (right, right_sum) = dfs(n.right, new_sum, limit);
                let mut new_node = Some(n);
                new_node.as_mut().unwrap().left = left;
                new_node.as_mut().unwrap().right = right;
                if left.is_none() && right.is_none() {
                    (None, new_sum)
                } else {
                    (new_node, new_sum)
                }
            } else {
                (None, sum)
            }
        }
        let (new_root, _) = dfs(root, 0, limit);
        new_root
    }
}