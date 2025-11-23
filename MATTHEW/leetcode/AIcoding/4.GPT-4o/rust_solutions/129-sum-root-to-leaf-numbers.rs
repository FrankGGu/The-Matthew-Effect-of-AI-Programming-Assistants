use crate::TreeNode;

pub fn sum_numbers(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: Option<&Box<TreeNode>>, current_sum: i32) -> i32 {
        match node {
            Some(n) => {
                let new_sum = current_sum * 10 + n.val;
                if n.left.is_none() && n.right.is_none() {
                    new_sum
                } else {
                    dfs(n.left.as_ref(), new_sum) + dfs(n.right.as_ref(), new_sum)
                }
            }
            None => 0,
        }
    }
    dfs(root.as_ref(), 0)
}