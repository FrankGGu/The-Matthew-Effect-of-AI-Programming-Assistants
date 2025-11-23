use std::collections::HashMap;

impl Solution {
    pub fn least_bricks(wall: Vec<Vec<i32>>) -> i32 {
        let mut gaps: HashMap<i32, i32> = HashMap::new();
        let mut max_gaps = 0;

        for row in &wall {
            let mut sum = 0;
            for i in 0..row.len() - 1 {
                sum += row[i];
                let count = gaps.entry(sum).or_insert(0);
                *count += 1;
                max_gaps = max_gaps.max(*count);
            }
        }

        wall.len() as i32 - max_gaps
    }
}