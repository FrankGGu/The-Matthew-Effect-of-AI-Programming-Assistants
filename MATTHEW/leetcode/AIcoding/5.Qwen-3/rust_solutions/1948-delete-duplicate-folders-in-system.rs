impl Solution {

use std::collections::{HashMap, HashSet};

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub children: Vec<TreeNode>,
}

impl TreeNode {
    pub fn new(val: i32) -> Self {
        TreeNode { val, children: vec![] }
    }
}

pub fn delete_duplicate_folders(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    fn dfs(
        node: &Box<TreeNode>,
        map: &mut HashMap<String, Vec<&Box<TreeNode>>>,
        result: &mut Vec<Box<TreeNode>>,
    ) {
        let mut key = String::new();
        key.push_str(&node.val.to_string());
        for child in &node.children {
            dfs(child, map, result);
            key.push('/');
            key.push_str(&child.val.to_string());
        }

        map.entry(key.clone()).or_insert_with(Vec::new).push(node);

        if map[&key].len() == 1 {
            result.push(node.clone());
        }
    }

    let mut map = HashMap::new();
    let mut result = Vec::new();

    if let Some(root) = root {
        dfs(&root, &mut map, &mut result);
        if result.is_empty() {
            return None;
        }
        let mut new_root = TreeNode::new(0);
        for node in result {
            new_root.children.push(node);
        }
        Some(Box::new(new_root))
    } else {
        None
    }
}
}