use crate::TreeNode;

pub fn sum_numbers(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, current_sum: i32) -> i32 {
        if let Some(n) = node {
            let new_sum = current_sum * 10 + n.val;
            if n.left.is_none() && n.right.is_none() {
                return new_sum;
            }
            dfs(&n.left, new_sum) + dfs(&n.right, new_sum)
        } else {
            0
        }
    }
    dfs(&root, 0)
}