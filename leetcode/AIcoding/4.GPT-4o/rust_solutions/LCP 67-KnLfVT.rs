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

pub fn decorate_tree(root: Option<Box<TreeNode>>, new_val: i32) -> Option<Box<TreeNode>> {
    fn dfs(node: &mut Option<Box<TreeNode>>, new_val: i32) {
        if let Some(ref mut n) = node {
            n.val += new_val;
            dfs(&mut n.left, new_val);
            dfs(&mut n.right, new_val);
        }
    }

    let mut root = root;
    dfs(&mut root, new_val);
    root
}