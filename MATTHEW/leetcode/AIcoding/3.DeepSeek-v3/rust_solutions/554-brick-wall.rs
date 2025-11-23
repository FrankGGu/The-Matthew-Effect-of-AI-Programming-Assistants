use std::collections::HashMap;

impl Solution {
    pub fn least_bricks(wall: Vec<Vec<i32>>) -> i32 {
        let mut edge_counts = HashMap::new();
        let mut max_edges = 0;

        for row in wall {
            let mut sum = 0;
            for brick in row.into_iter().take(row.len() - 1) {
                sum += brick;
                let count = edge_counts.entry(sum).or_insert(0);
                *count += 1;
                if *count > max_edges {
                    max_edges = *count;
                }
            }
        }

        wall.len() as i32 - max_edges
    }
}