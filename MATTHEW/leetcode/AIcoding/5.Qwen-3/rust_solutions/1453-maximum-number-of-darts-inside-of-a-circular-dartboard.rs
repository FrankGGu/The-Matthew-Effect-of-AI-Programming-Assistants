impl Solution {

use std::collections::HashMap;

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
    x: i32,
    y: i32,
}

impl Solution {
    pub fn max_number_of_darts(boxes: Vec<Vec<i32>>) -> i32 {
        let points: Vec<Point> = boxes.into_iter()
            .map(|b| Point { x: b[0], y: b[1] })
            .collect();

        let n = points.len();
        if n <= 2 {
            return n as i32;
        }

        let mut max_count = 0;

        for i in 0..n {
            let mut map = HashMap::new();
            let mut same = 0;
            let mut count = 0;

            for j in 0..n {
                if i == j {
                    continue;
                }

                if points[i].x == points[j].x && points[i].y == points[j].y {
                    same += 1;
                    continue;
                }

                let dx = points[j].x - points[i].x;
                let dy = points[j].y - points[i].y;

                let g = gcd(dx, dy);
                let key = ((dx / g) as i64 << 32) | (dy / g) as i64;

                *map.entry(key).or_insert(0) += 1;
                count = count.max(*map.get(&key).unwrap());
            }

            max_count = max_count.max(count + same + 1);
        }

        max_count
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a.abs()
        } else {
            Self::gcd(b, a % b)
        }
    }
}
}