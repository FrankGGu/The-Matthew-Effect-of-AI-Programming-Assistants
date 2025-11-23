impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn is_rectangle_cover(rects: Vec<Vec<i32>>) -> bool {
        let mut area = 0;
        let mut min_x = i32::MAX;
        let mut min_y = i32::MAX;
        let mut max_x = i32::MIN;
        let mut max_y = i32::MIN;
        let mut points = HashSet::new();

        for rect in &rects {
            let x1 = rect[0];
            let y1 = rect[1];
            let x2 = rect[2];
            let y2 = rect[3];

            area += (x2 - x1) * (y2 - y1);

            min_x = min_x.min(x1);
            min_y = min_y.min(y1);
            max_x = max_x.max(x2);
            max_y = max_y.max(y2);

            for &(x, y) in &[(x1, y1), (x1, y2), (x2, y1), (x2, y2)] {
                if points.contains(&(x, y)) {
                    points.remove(&(x, y));
                } else {
                    points.insert((x, y));
                }
            }
        }

        let expected_area = (max_x - min_x) * (max_y - min_y);
        if area != expected_area {
            return false;
        }

        points.len() == 4 && points.contains(&(min_x, min_y)) && points.contains(&(min_x, max_y)) && points.contains(&(max_x, min_y)) && points.contains(&(max_x, max_y))
    }
}
}