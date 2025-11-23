use std::collections::HashSet;
use std::cmp::min;

impl Solution {
    pub fn min_area_rect(points: Vec<Vec<i32>>) -> i32 {
        let mut point_set: HashSet<(i32, i32)> = HashSet::new();
        for p in &points {
            point_set.insert((p[0], p[1]));
        }

        let mut min_area = i32::MAX;

        for i in 0..points.len() {
            for j in (i + 1)..points.len() {
                let p1 = &points[i];
                let p2 = &points[j];

                let x1 = p1[0];
                let y1 = p1[1];
                let x2 = p2[0];
                let y2 = p2[1];

                if x1 == x2 || y1 == y2 {
                    continue;
                }

                if point_set.contains(&(x1, y2)) && point_set.contains(&(x2, y1)) {
                    let current_area = (x1 - x2).abs() * (y1 - y2).abs();
                    min_area = min(min_area, current_area);
                }
            }
        }

        if min_area == i32::MAX {
            0
        } else {
            min_area
        }
    }
}