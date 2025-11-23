use std::collections::HashSet;

impl Solution {
    pub fn find_smallest_set_of_vertices(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let mut reachable = HashSet::new();
        for edge in edges {
            reachable.insert(edge[1]);
        }
        (0..n).filter(|i| !reachable.contains(i)).collect()
    }
}