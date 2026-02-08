use std::collections::HashSet;

impl Solution {
    pub fn is_rectangle_cover(rectangles: Vec<Vec<i32>>) -> bool {
        if rectangles.is_empty() {
            return true;
        }

        let mut area = 0;
        let mut points = HashSet::new();
        let mut min_x = i32::MAX;
        let mut min_y = i32::MAX;
        let mut max_x = i32::MIN;
        let mut max_y = i32::MIN;

        for rect in &rectangles {
            let x1 = rect[0];
            let y1 = rect[1];
            let x2 = rect[2];
            let y2 = rect[3];

            area += (x2 - x1) * (y2 - y1);

            min_x = min_x.min(x1);
            min_y = min_y.min(y1);
            max_x = max_x.max(x2);
            max_y = max_y.max(y2);

            let p1 = (x1, y1);
            let p2 = (x1, y2);
            let p3 = (x2, y1);
            let p4 = (x2, y2);

            for p in [p1, p2, p3, p4] {
                if points.contains(&p) {
                    points.remove(&p);
                } else {
                    points.insert(p);
                }
            }
        }

        if points.len() != 4 {
            return false;
        }

        let expected_area = (max_x - min_x) * (max_y - min_y);

        points.contains(&(min_x, min_y))
            && points.contains(&(min_x, max_y))
            && points.contains(&(max_x, min_y))
            && points.contains(&(max_x, max_y))
            && area == expected_area
    }
}