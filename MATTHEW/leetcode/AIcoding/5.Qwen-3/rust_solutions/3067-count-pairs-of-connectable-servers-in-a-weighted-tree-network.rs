impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_pairs(root: Option<Box<TreeNode>>, k: i32, queries: Vec<i32>) -> Vec<i64> {
        let mut result = vec![0; queries.len()];
        let mut tree = HashMap::new();
        let mut nodes = vec![];
        build_tree(&root, None, &mut tree, &mut nodes);

        for (i, &q) in queries.iter().enumerate() {
            let mut counts = HashMap::new();
            let mut total = 0;
            for &node in &nodes {
                let mut path = vec![];
                let mut current = node;
                while let Some(parent) = tree.get(&current) {
                    path.push(current);
                    current = parent.0;
                }
                path.push(current);

                let mut sum = 0;
                for &p in &path {
                    let mut dist = 0;
                    let mut current_p = p;
                    while let Some(parent) = tree.get(&current_p) {
                        dist += 1;
                        current_p = parent.0;
                    }

                    if dist == q {
                        total += 1;
                    } else if dist < q {
                        *counts.entry(dist).or_insert(0) += 1;
                    }
                }

                for (d, &c) in &counts {
                    if d + q <= q {
                        total += c;
                    }
                }
            }
            result[i] = total;
        }

        result
    }
}

fn build_tree(node: &Option<Box<TreeNode>>, parent: Option<i32>, tree: &mut HashMap<i32, (i32, i32)>, nodes: &mut Vec<i32>) {
    if let Some(n) = node {
        nodes.push(n.val);
        if let Some(p) = parent {
            tree.insert(n.val, (p, n.weight));
        }
        build_tree(&n.left, Some(n.val), tree, nodes);
        build_tree(&n.right, Some(n.val), tree, nodes);
    }
}

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub weight: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub struct Solution {}
}