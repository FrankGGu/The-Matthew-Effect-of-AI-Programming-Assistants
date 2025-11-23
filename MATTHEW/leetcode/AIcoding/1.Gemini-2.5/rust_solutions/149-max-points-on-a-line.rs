use std::collections::HashMap;
use std::cmp;

fn gcd(a: i32, b: i32) -> i32 {
    let mut a = a.abs();
    let mut b = b.abs();
    while b != 0 {
        let temp = b;
        b = a % b;
        a = temp;
    }
    a
}

impl Solution {
    pub fn max_points(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        if n <= 2 {
            return n as i32;
        }

        let mut max_total_points = 0;

        for i in 0..n {
            let p1 = &points[i];
            let mut current_max_for_p1 = 0;
            let mut duplicates = 0;
            let mut slopes: HashMap<(i32, i32), i32> = HashMap::new();

            for j in i + 1..n {
                let p2 = &points[j];

                let mut dx = p2[0] - p1[0];
                let mut dy = p2[1] - p1[1];

                if dx == 0 && dy == 0 {
                    duplicates += 1;
                    continue;
                }

                let common_divisor = gcd(dx, dy);
                dy /= common_divisor;
                dx /= common_divisor;

                if dx < 0 || (dx == 0 && dy < 0) {
                    dx = -dx;
                    dy = -dy;
                }

                *slopes.entry((dy, dx)).or_insert(0) += 1;
                current_max_for_p1 = cmp::max(current_max_for_p1, *slopes.get(&(dy, dx)).unwrap());
            }

            max_total_points = cmp::max(max_total_points, current_max_for_p1 + duplicates + 1);
        }

        max_total_points
    }
}