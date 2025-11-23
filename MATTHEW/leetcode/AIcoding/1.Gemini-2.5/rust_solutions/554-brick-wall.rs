use std::collections::HashMap;

impl Solution {
    pub fn least_bricks(wall: Vec<Vec<i32>>) -> i32 {
        let mut gap_frequencies: HashMap<i32, i32> = HashMap::new();
        let total_rows = wall.len() as i32;

        for row in wall {
            let mut current_sum = 0;
            // Iterate through bricks, but stop before the last brick
            // because a line cannot be drawn along the vertical edges of the wall.
            if row.len() > 0 { // Ensure row is not empty, though problem constraints usually prevent this.
                for i in 0..row.len() - 1 {
                    current_sum += row[i];
                    *gap_frequencies.entry(current_sum).or_insert(0) += 1;
                }
            }
        }

        let mut max_frequency = 0;
        for &freq in gap_frequencies.values() {
            if freq > max_frequency {
                max_frequency = freq;
            }
        }

        total_rows - max_frequency
    }
}