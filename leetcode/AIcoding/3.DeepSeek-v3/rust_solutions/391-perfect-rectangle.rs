use std::collections::HashSet;

impl Solution {
    pub fn is_rectangle_cover(rectangles: Vec<Vec<i32>>) -> bool {
        let mut corners = HashSet::new();
        let (mut x1, mut y1, mut x2, mut y2) = (i32::MAX, i32::MAX, i32::MIN, i32::MIN);
        let mut area = 0;

        for rect in rectangles {
            let (a, b, c, d) = (rect[0], rect[1], rect[2], rect[3]);
            x1 = x1.min(a);
            y1 = y1.min(b);
            x2 = x2.max(c);
            y2 = y2.max(d);
            area += (c - a) * (d - b);

            let points = [(a, b), (a, d), (c, b), (c, d)];
            for p in points.iter() {
                if !corners.insert(*p) {
                    corners.remove(p);
                }
            }
        }

        let expected_area = (x2 - x1) * (y2 - y1);
        if area != expected_area {
            return false;
        }

        if corners.len() != 4 {
            return false;
        }

        let expected_corners = [(x1, y1), (x1, y2), (x2, y1), (x2, y2)];
        for p in expected_corners.iter() {
            if !corners.contains(p) {
                return false;
            }
        }

        true
    }
}