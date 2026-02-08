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
                if points[i][0] != points[j][0] && points[i][1] != points[j][1] {
                    let p1 = (points[i][0], points[j][1]);
                    let p2 = (points[j][0], points[i][1]);
                    if point_set.contains(&p1) && point_set.contains(&p2) {
                        let area = (points[i][0] - points[j][0]).abs() * (points[i][1] - points[j][1]).abs();
                        min_area = min_area.min(area);
                    }
                }
            }
        }

        if min_area == i32::MAX { 0 } else { min_area }
    }
}