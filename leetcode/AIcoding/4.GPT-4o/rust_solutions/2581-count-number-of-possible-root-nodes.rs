use std::collections::HashMap;

pub struct Solution;

impl Solution {
    pub fn count_possible_root_nodes(edges: Vec<Vec<i32>>) -> i32 {
        let mut indegree = HashMap::new();

        for edge in edges.iter() {
            *indegree.entry(edge[1]).or_insert(0) += 1;
            indegree.entry(edge[0]).or_insert(0);
        }

        indegree.iter().filter(|(_, &deg)| deg == 0).count() as i32
    }
}