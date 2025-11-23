use std::collections::HashMap;

impl Solution {
    pub fn count_pairs(points: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut count = 0;
        let mut freq = HashMap::new();

        for point in points.iter() {
            let x = point[0];
            let y = point[1];
            for a in 0..=k {
                let b = k - a;
                let target_x = x ^ a;
                let target_y = y ^ b;
                count += freq.get(&(target_x, target_y)).unwrap_or(&0);
            }
            *freq.entry((x, y)).or_insert(0) += 1;
        }

        count
    }
}