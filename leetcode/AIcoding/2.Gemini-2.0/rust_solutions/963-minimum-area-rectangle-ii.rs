use std::collections::HashMap;

impl Solution {
    pub fn min_area_free_rect(points: Vec<Vec<i32>>) -> f64 {
        let n = points.len();
        let mut map: HashMap<(i32, i32), Vec<(usize, usize)>> = HashMap::new();
        let mut ans = std::f64::MAX;

        for i in 0..n {
            for j in i + 1..n {
                let p1 = &points[i];
                let p2 = &points[j];
                let dx = p1[0] - p2[0];
                let dy = p1[1] - p2[1];

                map.entry((dx * dx + dy * dy, (p1[0] + p2[0], p1[1] + p2[1])))
                    .or_insert(Vec::new())
                    .push((i, j));
            }
        }

        for (_, pairs) in map.iter() {
            for k in 0..pairs.len() {
                for l in k + 1..pairs.len() {
                    let (i, j) = pairs[k];
                    let (m, n_) = pairs[l];

                    let p1 = &points[i];
                    let p2 = &points[j];
                    let p3 = &points[m];
                    let p4 = &points[n_];

                    let v1x = p2[0] - p1[0];
                    let v1y = p2[1] - p1[1];
                    let v2x = p4[0] - p3[0];
                    let v2y = p4[1] - p3[1];

                    if v1x * v2x + v1y * v2y == 0 {
                        let side1 = (((p2[0] - p1[0]) * (p2[0] - p1[0]) + (p2[1] - p1[1]) * (p2[1] - p1[1])) as f64).sqrt();
                        let side2 = (((p3[0] - p1[0]) * (p3[0] - p1[0]) + (p3[1] - p1[1]) * (p3[1] - p1[1])) as f64).sqrt();
                        ans = ans.min(side1 * side2);
                    }
                }
            }
        }

        if ans == std::f64::MAX {
            0.0
        } else {
            ans
        }
    }
}