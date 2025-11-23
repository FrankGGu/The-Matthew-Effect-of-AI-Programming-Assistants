use std::collections::HashSet;
use std::cmp::{min, max};

impl Solution {
    pub fn is_rectangle_cover(rectangles: Vec<Vec<i32>>) -> bool {
        if rectangles.is_empty() {
            return false;
        }

        let mut min_x = i32::MAX;
        let mut min_y = i32::MAX;
        let mut max_x = i32::MIN;
        let mut max_y = i32::MIN;
        let mut total_area: i64 = 0;

        let mut corners: HashSet<(i32, i32)> = HashSet::new();

        for rect in rectangles {
            let x1 = rect[0];
            let y1 = rect[1];
            let x2 = rect[2];
            let y2 = rect[3];

            min_x = min(min_x, x1);
            min_y = min(min_y, y1);
            max_x = max(max_x, x2);
            max_y = max(max_y, y2);

            total_area += (x2 - x1) as i64 * (y2 - y1) as i64;

            for &p in &[(x1, y1), (x1, y2), (x2, y1), (x2, y2)] {
                if !corners.insert(p) {
                    corners.remove(&p);
                }
            }
        }

        if corners.len() != 4 {
            return false;
        }

        if !corners.contains(&(min_x, min_y)) ||
           !corners.contains(&(min_x, max_y)) ||
           !corners.contains(&(max_x, min_y)) ||
           !corners.contains(&(max_x, max_y)) {
            return false;
        }

        let bounding_box_area = (max_x - min_x) as i64 * (max_y - min_y) as i64;
        if total_area != bounding_box_area {
            return false;
        }

        true
    }
}