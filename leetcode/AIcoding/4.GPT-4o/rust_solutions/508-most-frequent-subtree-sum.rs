use std::collections::HashMap;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub struct Solution;

impl Solution {
    pub fn find_frequent_tree_sum(root: Option<Box<TreeNode>>) -> Vec<i32> {
        let mut count = HashMap::new();
        let mut max_count = 0;

        fn subtree_sum(node: &Option<Box<TreeNode>>, count: &mut HashMap<i32, i32>, max_count: &mut i32) -> i32 {
            if let Some(n) = node {
                let left_sum = subtree_sum(&n.left, count, max_count);
                let right_sum = subtree_sum(&n.right, count, max_count);
                let sum = n.val + left_sum + right_sum;
                let entry = count.entry(sum).or_insert(0);
                *entry += 1;
                *max_count = (*max_count).max(*entry);
                sum
            } else {
                0
            }
        }

        subtree_sum(&root, &mut count, &mut max_count);

        count.into_iter()
            .filter(|&(_, v)| v == max_count)
            .map(|(k, _)| k)
            .collect()
    }
}