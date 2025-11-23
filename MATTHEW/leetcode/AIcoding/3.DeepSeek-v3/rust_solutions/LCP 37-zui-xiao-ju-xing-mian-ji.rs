use std::collections::HashSet;

impl Solution {
    pub fn min_area_rect(points: Vec<Vec<i32>>) -> i32 {
        let point_set: HashSet<(i32, i32)> = points.iter().map(|p| (p[0], p[1])).collect();
        let mut min_area = i32::MAX;
        let n = points.len();

        for i in 0..n {
            for j in i+1..n {
                let (x1, y1) = (points[i][0], points[i][1]);
                let (x2, y2) = (points[j][0], points[j][1]);

                if x1 != x2 && y1 != y2 {
                    if point_set.contains(&(x1, y2)) && point_set.contains(&(x2, y1)) {
                        let area = (x1 - x2).abs() * (y1 - y2).abs();
                        if area < min_area {
                            min_area = area;
                        }
                    }
                }
            }
        }

        if min_area == i32::MAX { 0 } else { min_area }
    }
}