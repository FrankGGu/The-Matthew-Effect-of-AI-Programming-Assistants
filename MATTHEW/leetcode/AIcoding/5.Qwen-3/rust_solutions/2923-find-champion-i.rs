impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn find_champion(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let mut in_degree = vec![0; n as usize];
        for edge in edges {
            in_degree[edge[1] as usize] += 1;
        }

        let mut candidates = Vec::new();
        for i in 0..n as usize {
            if in_degree[i] == 0 {
                candidates.push(i as i32);
            }
        }

        match candidates.len() {
            1 => candidates[0],
            _ => -1,
        }
    }
}
}