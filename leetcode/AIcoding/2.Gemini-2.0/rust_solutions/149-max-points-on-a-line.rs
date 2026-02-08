use std::collections::HashMap;

impl Solution {
    pub fn max_points(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        if n <= 2 {
            return n as i32;
        }

        let mut max_count = 0;
        for i in 0..n {
            let mut slopes: HashMap<String, i32> = HashMap::new();
            let mut same_points = 1;
            let mut vertical_points = 0;

            for j in i + 1..n {
                if points[i][0] == points[j][0] && points[i][1] == points[j][1] {
                    same_points += 1;
                } else if points[i][0] == points[j][0] {
                    vertical_points += 1;
                } else {
                    let dy = points[j][1] - points[i][1];
                    let dx = points[j][0] - points[i][0];
                    let gcd_val = Self::gcd(dy, dx);
                    let slope = format!("{}/{}", dy / gcd_val, dx / gcd_val);
                    *slopes.entry(slope).or_insert(0) += 1;
                }
            }

            let mut max_slope_count = 0;
            for (_, count) in slopes.iter() {
                max_slope_count = max_slope_count.max(*count);
            }

            max_count = max_count.max(same_points + vertical_points);
            max_count = max_count.max(same_points + max_slope_count);
        }

        max_count as i32
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a.abs()
        } else {
            Self::gcd(b, a % b)
        }
    }
}

struct Solution;