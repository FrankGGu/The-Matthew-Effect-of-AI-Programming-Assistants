use std::collections::HashMap;

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

pub fn color_tree(root: Option<Box<TreeNode>>, color: i32) -> HashMap<i32, i32> {
    let mut count = HashMap::new();
    fn dfs(node: &Option<Box<TreeNode>>, color: i32, count: &mut HashMap<i32, i32>) {
        if let Some(n) = node {
            let val = n.val;
            *count.entry(val).or_insert(0) += color;
            dfs(&n.left, color, count);
            dfs(&n.right, color, count);
        }
    }
    dfs(&root, color, &mut count);
    count
}