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

pub fn count_pairs(root: Option<Box<TreeNode>>, distance: i32) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, distance: i32, counter: &mut HashMap<i32, i32>) -> Vec<i32> {
        if let Some(n) = node {
            let mut left_counts = dfs(&n.left, distance, counter);
            let mut right_counts = dfs(&n.right, distance, counter);
            let mut result = vec![0; distance as usize];

            for l in left_counts {
                for r in right_counts.iter() {
                    if l + r + 2 <= distance {
                        *counter.entry(l + r + 2).or_insert(0) += 1;
                    }
                }
            }

            for i in 0..left_counts.len() {
                if i as i32 + 1 < distance {
                    result[i as usize + 1] += left_counts[i];
                }
            }
            for i in 0..right_counts.len() {
                if i as i32 + 1 < distance {
                    result[i as usize + 1] += right_counts[i];
                }
            }

            result.push(1);
            result
        } else {
            vec![]
        }
    }

    let mut counter = HashMap::new();
    dfs(&root, distance, &mut counter);
    counter.values().map(|&v| v).sum()
}