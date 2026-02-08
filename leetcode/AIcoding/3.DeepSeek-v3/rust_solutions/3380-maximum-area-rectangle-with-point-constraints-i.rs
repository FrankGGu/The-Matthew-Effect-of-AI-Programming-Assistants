use std::collections::HashSet;

impl Solution {
    pub fn max_area(rectangles: Vec<Vec<i32>>, points: Vec<Vec<i32>>) -> i64 {
        let mut max_area = 0;
        let point_set: HashSet<(i32, i32)> = points.into_iter().map(|p| (p[0], p[1])).collect();

        for rect in rectangles {
            let (x1, y1, x2, y2) = (rect[0], rect[1], rect[2], rect[3]);
            let area = (x2 - x1) as i64 * (y2 - y1) as i64;

            if area <= max_area {
                continue;
            }

            let corners = [(x1, y1), (x1, y2), (x2, y1), (x2, y2)];
            let mut contains_all = true;

            for &corner in &corners {
                if !point_set.contains(&corner) {
                    contains_all = false;
                    break;
                }
            }

            if contains_all {
                max_area = max_area.max(area);
            }
        }

        max_area
    }
}