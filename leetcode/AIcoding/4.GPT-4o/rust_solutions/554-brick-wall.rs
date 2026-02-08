use std::collections::HashMap;

impl Solution {
    pub fn least_bricks(wall: Vec<Vec<i32>>) -> i32 {
        let mut width_count = HashMap::new();
        let total_width = wall[0].iter().sum::<i32>();

        for row in wall {
            let mut width = 0;
            for brick in row.iter().take(row.len() - 1) {
                width += brick;
                *width_count.entry(width).or_insert(0) += 1;
            }
        }

        let max_edges = width_count.values().max().unwrap_or(&0);
        (wall.len() as i32) - max_edges
    }
}