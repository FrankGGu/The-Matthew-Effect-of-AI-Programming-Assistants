impl Solution {

use std::collections::{HashSet, VecDeque};

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub neighbors: Vec<TreeNode>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            neighbors: Vec::new(),
        }
    }
}

pub fn get_ancestors(n: i32, edges: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let n = n as usize;
    let mut graph = vec![Vec::new(); n];

    for edge in edges {
        let u = edge[0] as usize;
        let v = edge[1] as usize;
        graph[u].push(v);
    }

    let mut result = vec![HashSet::new(); n];

    for i in 0..n {
        let mut queue = VecDeque::new();
        queue.push_back(i);

        let mut visited = HashSet::new();
        visited.insert(i);

        while let Some(node) = queue.pop_front() {
            for &neighbor in &graph[node] {
                if !visited.contains(&neighbor) {
                    visited.insert(neighbor);
                    queue.push_back(neighbor);
                    result[neighbor].insert(i);
                }
            }
        }
    }

    result.into_iter()
        .map(|set| {
            let mut vec: Vec<i32> = set.into_iter().collect();
            vec.sort();
            vec
        })
        .collect()
}
}