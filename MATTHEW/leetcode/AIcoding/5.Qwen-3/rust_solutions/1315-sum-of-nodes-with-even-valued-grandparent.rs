impl Solution {

#[derive(Debug, PartialEq, Eq)]
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

pub fn sum_even_grandparent(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, parent: i32, grand_parent: i32, result: &mut i32) {
        if let Some(n) = node {
            if grand_parent % 2 == 0 {
                *result += n.val;
            }
            dfs(&n.left, n.val, parent, result);
            dfs(&n.right, n.val, parent, result);
        }
    }

    let mut result = 0;
    dfs(&root, 1, 1, &mut result);
    result
}
}