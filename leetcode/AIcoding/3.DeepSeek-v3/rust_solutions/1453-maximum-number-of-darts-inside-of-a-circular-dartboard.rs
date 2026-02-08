use std::f64::consts::PI;

impl Solution {
    pub fn num_points(darts: Vec<Vec<i32>>, r: i32) -> i32 {
        let r = r as f64;
        let n = darts.len();
        if n == 1 {
            return 1;
        }
        let mut max_count = 1;
        for i in 0..n {
            for j in i + 1..n {
                let (x1, y1) = (darts[i][0] as f64, darts[i][1] as f64);
                let (x2, y2) = (darts[j][0] as f64, darts[j][1] as f64);
                let d = ((x1 - x2).powi(2) + (y1 - y2).powi(2)).sqrt();
                if d > 2.0 * r {
                    continue;
                }
                let mid_x = (x1 + x2) / 2.0;
                let mid_y = (y1 + y2) / 2.0;
                let h = (r.powi(2) - (d / 2.0).powi(2)).sqrt();
                let angle = (y2 - y1).atan2(x2 - x1);
                let c1_x = mid_x + h * angle.sin();
                let c1_y = mid_y - h * angle.cos();
                let c2_x = mid_x - h * angle.sin();
                let c2_y = mid_y + h * angle.cos();
                let centers = vec![(c1_x, c1_y), (c2_x, c2_y)];
                for (cx, cy) in centers {
                    let mut count = 0;
                    for point in &darts {
                        let (px, py) = (point[0] as f64, point[1] as f64);
                        if (px - cx).powi(2) + (py - cy).powi(2) <= r.powi(2) + 1e-6 {
                            count += 1;
                        }
                    }
                    max_count = max_count.max(count);
                }
            }
        }
        max_count
    }
}