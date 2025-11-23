impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_boomerangs(points: Vec<Vec<i32>>) -> i32 {
        let mut result = 0;
        for i in 0..points.len() {
            let mut map = HashMap::new();
            for j in 0..points.len() {
                if i == j {
                    continue;
                }
                let dx = points[i][0] - points[j][0];
                let dy = points[i][1] - points[j][1];
                let dist = dx * dx + dy * dy;
                *map.entry(dist).or_insert(0) += 1;
            }
            for count in map.values() {
                result += count * (count - 1);
            }
        }
        result
    }
}
}