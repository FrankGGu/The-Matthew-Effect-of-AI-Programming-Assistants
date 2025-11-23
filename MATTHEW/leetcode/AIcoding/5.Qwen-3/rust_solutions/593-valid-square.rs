impl Solution {

use std::collections::HashSet;

#[derive(PartialEq, Eq, Hash, Clone, Copy)]
struct Point {
    x: i32,
    y: i32,
}

impl Solution {
    pub fn valid_square(p1: Vec<i32>, p2: Vec<i32>, p3: Vec<i32>, p4: Vec<i32>) -> bool {
        let points = vec![
            Point { x: p1[0], y: p1[1] },
            Point { x: p2[0], y: p2[1] },
            Point { x: p3[0], y: p3[1] },
            Point { x: p4[0], y: p4[1] },
        ];

        let mut dists = HashSet::new();

        for i in 0..4 {
            for j in i + 1..4 {
                let dx = points[i].x - points[j].x;
                let dy = points[i].y - points[j].y;
                let dist = dx * dx + dy * dy;
                dists.insert(dist);
            }
        }

        dists.len() == 2 && !dists.contains(&0)
    }
}
}