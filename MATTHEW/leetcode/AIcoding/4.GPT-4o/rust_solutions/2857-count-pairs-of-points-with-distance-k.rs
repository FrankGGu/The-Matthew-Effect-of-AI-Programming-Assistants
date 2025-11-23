use std::collections::HashMap;

impl Solution {
    pub fn count_pairs(points: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut count = 0;
        let mut map = HashMap::new();

        for point in &points {
            let dist = point[0] * point[0] + point[1] * point[1];
            let target = dist - k * k;
            count += map.get(&target).unwrap_or(&0);
            *map.entry(dist).or_insert(0) += 1;
        }

        count
    }
}