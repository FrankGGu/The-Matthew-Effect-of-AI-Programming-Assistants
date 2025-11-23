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

pub fn find_target(root: Option<Box<TreeNode>>, k: i32) -> bool {
    let mut map = HashMap::new();
    fn dfs(node: &Option<Box<TreeNode>>, k: i32, map: &mut HashMap<i32, bool>) -> bool {
        if let Some(n) = node {
            if map.contains_key(&(k - n.val)) {
                return true;
            }
            map.insert(n.val, true);
            return dfs(&n.left, k, map) || dfs(&n.right, k, map);
        }
        false
    }
    dfs(&root, k, &mut map)
}