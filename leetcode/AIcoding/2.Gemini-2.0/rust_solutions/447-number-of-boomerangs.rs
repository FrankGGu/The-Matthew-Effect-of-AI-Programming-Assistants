use std::collections::HashMap;

impl Solution {
    pub fn number_of_boomerangs(points: Vec<Vec<i32>>) -> i32 {
        let mut res = 0;
        for i in 0..points.len() {
            let mut map: HashMap<i32, i32> = HashMap::new();
            for j in 0..points.len() {
                if i == j {
                    continue;
                }
                let dist = (points[i][0] - points[j][0]).pow(2) + (points[i][1] - points[j][1]).pow(2);
                *map.entry(dist).or_insert(0) += 1;
            }
            for &val in map.values() {
                res += val * (val - 1);
            }
        }
        res
    }
}