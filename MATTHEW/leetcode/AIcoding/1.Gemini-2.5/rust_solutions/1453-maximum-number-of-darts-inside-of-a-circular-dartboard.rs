use std::f64;

impl Solution {
    pub fn num_points(points: Vec<Vec<i32>>, r: i32) -> i32 {
        let n = points.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return 1;
        }

        let r_f64 = r as f64;
        let r_sq = r_f64 * r_f64;
        let epsilon = 1e-9;

        let mut max_darts = 1;

        let points_f64: Vec<(f64, f64)> = points.into_iter().map(|p| (p[0] as f64, p[1] as f64)).collect();

        for i in 0..n {
            for j in i + 1..n {
                let p1 = points_f64[i];
                let p2 = points_f64[j];

                let dx = p2.0 - p1.0;
                let dy = p2.1 - p1.1;
                let d_sq = dx * dx + dy * dy;

                if d_sq > (2.0 * r_f64) * (2.0 * r_f64) + epsilon {
                    continue;
                }

                if d_sq < epsilon {
                    continue;
                }

                let d = d_sq.sqrt();

                let mid_x = (p1.0 + p2.0) / 2.0;
                let mid_y = (p1.1 + p2.1) / 2.0;

                let h_sq = r_sq - (d / 2.0) * (d / 2.0);
                let h = h_sq.max(0.0).sqrt();

                let perp_dx = -dy;
                let perp_dy = dx;
                let perp_len = (perp_dx * perp_dx + perp_dy * perp_dy).sqrt();

                let unit_perp_dx = perp_dx / perp_len;
                let unit_perp_dy = perp_dy / perp_len;

                let c1_x = mid_x + h * unit_perp_dx;
                let c1_y = mid_y + h * unit_perp_dy;

                let c2_x = mid_x - h * unit_perp_dx;
                let c2_y = mid_y - h * unit_perp_dy;

                let mut current_darts_c1 = 0;
                for k in 0..n {
                    let pk = points_f64[k];
                    let dist_to_center_sq = (pk.0 - c1_x) * (pk.0 - c1_x) + (pk.1 - c1_y) * (pk.1 - c1_y);
                    if dist_to_center_sq <= r_sq + epsilon {
                        current_darts_c1 += 1;
                    }
                }
                max_darts = max_darts.max(current_darts_c1);

                if h > epsilon {
                    let mut current_darts_c2 = 0;
                    for k in 0..n {
                        let pk = points_f64[k];
                        let dist_to_center_sq = (pk.0 - c2_x) * (pk.0 - c2_x) + (pk.1 - c2_y) * (pk.1 - c2_y);
                        if dist_to_center_sq <= r_sq + epsilon {
                            current_darts_c2 += 1;
                        }
                    }
                    max_darts = max_darts.max(current_darts_c2);
                }
            }
        }

        max_darts
    }
}