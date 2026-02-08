use crate::util::TreeNode;

impl Solution {
    pub fn rob(root: Option<Box<TreeNode>>) -> i32 {
        fn dfs(node: Option<&Box<TreeNode>>) -> (i32, i32) {
            if let Some(n) = node {
                let (left_rob, left_not_rob) = dfs(n.left.as_ref());
                let (right_rob, right_not_rob) = dfs(n.right.as_ref());
                let rob_this = n.val + left_not_rob + right_not_rob;
                let not_rob_this = left_rob.max(left_not_rob) + right_rob.max(right_not_rob);
                (rob_this, not_rob_this)
            } else {
                (0, 0)
            }
        }
        let (rob, not_rob) = dfs(root.as_ref());
        rob.max(not_rob)
    }
}