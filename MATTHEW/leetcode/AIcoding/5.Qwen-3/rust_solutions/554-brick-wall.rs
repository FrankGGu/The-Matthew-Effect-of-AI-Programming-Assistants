impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn least_bricks(wall: Vec<Vec<i32>>) -> i32 {
        let mut map = HashMap::new();
        for row in wall {
            let mut pos = 0;
            for i in 0..row.len() - 1 {
                pos += row[i];
                *map.entry(pos).or_insert(0) += 1;
            }
        }
        let mut max = 0;
        for v in map.values() {
            if *v > max {
                max = *v;
            }
        }
        max
    }
}
}