impl Solution {
    pub fn num_toy_boomerangs(points: Vec<Vec<i32>>) -> i32 {
        let mut res = 0;
        for i in 0..points.len() {
            let mut dist_map = std::collections::HashMap::new();
            for j in 0..points.len() {
                if i == j {
                    continue;
                }
                let dx = points[i][0] - points[j][0];
                let dy = points[i][1] - points[j][1];
                let dist = dx * dx + dy * dy;
                *dist_map.entry(dist).or_insert(0) += 1;
            }
            for &count in dist_map.values() {
                res += count * (count - 1);
            }
        }
        res
    }
}