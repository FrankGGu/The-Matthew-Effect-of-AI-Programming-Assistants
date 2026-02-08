use std::collections::HashMap;

impl Solution {
    pub fn number_of_boomerangs(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        let mut total_boomerangs = 0;

        for i in 0..n {
            let mut distances_map: HashMap<i32, i32> = HashMap::new();
            for j in 0..n {
                if i == j {
                    continue;
                }

                let dx = points[i][0] - points[j][0];
                let dy = points[i][1] - points[j][1];
                let squared_dist = dx * dx + dy * dy;

                *distances_map.entry(squared_dist).or_insert(0) += 1;
            }

            for (_dist, count) in distances_map.iter() {
                if *count >= 2 {
                    total_boomerangs += count * (count - 1);
                }
            }
        }

        total_boomerangs
    }
}