use std::cmp;

impl Solution {
    pub fn num_points(points: Vec<Vec<i32>>, r: i32) -> i32 {
        let n = points.len();
        let r = r as f64;
        let mut ans = 1;

        for i in 0..n {
            for j in i + 1..n {
                let p1 = (points[i][0] as f64, points[i][1] as f64);
                let p2 = (points[j][0] as f64, points[j][1] as f64);
                let dist = ((p1.0 - p2.0).powi(2) + (p1.1 - p2.1).powi(2)).sqrt();

                if dist > 2.0 * r {
                    continue;
                }

                let mid_x = (p1.0 + p2.0) / 2.0;
                let mid_y = (p1.1 + p2.1) / 2.0;
                let d = (r.powi(2) - (dist / 2.0).powi(2)).sqrt();

                let dx = (p2.1 - p1.1) * d / (dist / 2.0);
                let dy = (p1.0 - p2.0) * d / (dist / 2.0);

                let center1 = (mid_x + dx, mid_y + dy);
                let center2 = (mid_x - dx, mid_y - dy);

                let mut count1 = 0;
                for k in 0..n {
                    let p = (points[k][0] as f64, points[k][1] as f64);
                    let dist = ((p.0 - center1.0).powi(2) + (p.1 - center1.1).powi(2)).sqrt();
                    if dist <= r + 1e-9 {
                        count1 += 1;
                    }
                }

                let mut count2 = 0;
                for k in 0..n {
                    let p = (points[k][0] as f64, points[k][1] as f64);
                    let dist = ((p.0 - center2.0).powi(2) + (p.1 - center2.1).powi(2)).sqrt();
                    if dist <= r + 1e-9 {
                        count2 += 1;
                    }
                }

                ans = cmp::max(ans, cmp::max(count1, count2));
            }
        }

        ans
    }
}