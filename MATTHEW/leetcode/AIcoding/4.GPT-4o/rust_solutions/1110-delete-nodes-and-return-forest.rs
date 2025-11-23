use std::collections::HashSet;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub struct Solution;

impl Solution {
    pub fn del_nodes(root: Option<Box<TreeNode>>, to_delete: Vec<i32>) -> Vec<Option<Box<TreeNode>>> {
        let to_delete_set: HashSet<i32> = to_delete.into_iter().collect();
        let mut forest = Vec::new();
        Self::dfs(root, &to_delete_set, &mut forest);
        forest
    }

    fn dfs(node: Option<Box<TreeNode>>, to_delete_set: &HashSet<i32>, forest: &mut Vec<Option<Box<TreeNode>>>) -> Option<Box<TreeNode>> {
        if node.is_none() {
            return None;
        }

        let mut node = node.unwrap();
        let left = Self::dfs(node.left.take(), to_delete_set, forest);
        let right = Self::dfs(node.right.take(), to_delete_set, forest);

        node.left = left;
        node.right = right;

        if to_delete_set.contains(&node.val) {
            if let Some(left_node) = node.left {
                forest.push(Some(left_node));
            }
            if let Some(right_node) = node.right {
                forest.push(Some(right_node));
            }
            return None;
        }

        Some(node)
    }
}