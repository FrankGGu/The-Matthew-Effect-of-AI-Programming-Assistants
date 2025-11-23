use std::collections::HashMap;

pub struct Solution;

impl Solution {
    pub fn max_points(points: Vec<Vec<i32>>) -> i32 {
        if points.len() < 2 {
            return points.len() as i32;
        }

        let mut max_points = 0;
        let n = points.len();

        for i in 0..n {
            let mut slopes = HashMap::new();
            for j in 0..n {
                if i != j {
                    let dx = points[j][0] - points[i][0];
                    let dy = points[j][1] - points[i][1];
                    let g = Self::gcd(dx, dy);
                    let slope = (dy / g, dx / g);
                    *slopes.entry(slope).or_insert(0) += 1;
                }
            }
            let local_max = slopes.values().max().unwrap_or(&0) + 1;
            max_points = max_points.max(local_max);
        }

        max_points
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a.abs()
        } else {
            Self::gcd(b, a % b)
        }
    }
}