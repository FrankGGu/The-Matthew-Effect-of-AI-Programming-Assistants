use std::collections::HashMap;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub struct Solution;

impl Solution {
    pub fn flip_match_voyage(root: Option<Box<TreeNode>>, voyage: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut index = 0;
        let mut map = HashMap::new();
        Solution::preorder_map(&root, &mut map);
        if Self::dfs(&root, &mut index, &voyage, &mut result, &map) {
            result
        } else {
            vec![-1]
        }
    }

    fn preorder_map(node: &Option<Box<TreeNode>>, map: &mut HashMap<i32, &Option<Box<TreeNode>>>) {
        if let Some(n) = node {
            map.insert(n.val, Some(n));
            Self::preorder_map(&n.left, map);
            Self::preorder_map(&n.right, map);
        }
    }

    fn dfs(
        node: &Option<Box<TreeNode>>,
        index: &mut usize,
        voyage: &Vec<i32>,
        result: &mut Vec<i32>,
        map: &HashMap<i32, &Option<Box<TreeNode>>>,
    ) -> bool {
        if node.is_none() {
            return true;
        }
        let n = node.as_ref().unwrap();
        if *index >= voyage.len() || n.val != voyage[*index] {
            return false;
        }
        *index += 1;
        if let Some(left) = &n.left {
            if *index < voyage.len() && voyage[*index] == left.val {
                return Self::dfs(&n.left, index, voyage, result, map) && Self::dfs(&n.right, index, voyage, result, map);
            } else {
                result.push(n.val);
                return Self::dfs(&n.right, index, voyage, result, map) && Self::dfs(&n.left, index, voyage, result, map);
            }
        }
        Self::dfs(&n.right, index, voyage, result, map)
    }
}