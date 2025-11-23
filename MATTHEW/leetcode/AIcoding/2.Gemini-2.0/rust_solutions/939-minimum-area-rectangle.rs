use std::collections::HashSet;

impl Solution {
    pub fn min_area_rect(points: Vec<Vec<i32>>) -> i32 {
        let mut point_set = HashSet::new();
        for point in &points {
            point_set.insert((point[0], point[1]));
        }

        let mut min_area = i32::MAX;
        for i in 0..points.len() {
            for j in i + 1..points.len() {
                let p1 = &points[i];
                let p2 = &points[j];

                if p1[0] == p2[0] || p1[1] == p2[1] {
                    continue;
                }

                let p3 = (p1[0], p2[1]);
                let p4 = (p2[0], p1[1]);

                if point_set.contains(&p3) && point_set.contains(&p4) {
                    let area = (p1[0] - p2[0]).abs() * (p1[1] - p2[1]).abs();
                    min_area = min_area.min(area);
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