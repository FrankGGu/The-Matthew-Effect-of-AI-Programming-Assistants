use std::collections::HashMap;

impl Solution {
    pub fn max_points(points: Vec<Vec<i32>>) -> i32 {
        if points.len() <= 2 {
            return points.len() as i32;
        }

        let mut max_count = 0;

        for i in 0..points.len() {
            let mut slope_counts = HashMap::new();
            let mut same_point = 0;
            let mut current_max = 0;

            for j in i+1..points.len() {
                let x1 = points[i][0];
                let y1 = points[i][1];
                let x2 = points[j][0];
                let y2 = points[j][1];

                let dx = x2 - x1;
                let dy = y2 - y1;

                if dx == 0 && dy == 0 {
                    same_point += 1;
                    continue;
                }

                let gcd_val = gcd(dx, dy);
                let slope = if gcd_val == 0 {
                    (0, 0)
                } else {
                    (dx / gcd_val, dy / gcd_val)
                };

                let count = slope_counts.entry(slope).or_insert(0);
                *count += 1;
                current_max = current_max.max(*count);
            }

            max_count = max_count.max(current_max + same_point + 1);
        }

        max_count
    }
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}