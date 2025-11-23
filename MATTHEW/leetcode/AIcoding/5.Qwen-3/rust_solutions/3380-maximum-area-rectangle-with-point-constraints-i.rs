impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn max_area(rectangles: Vec<Vec<i32>>) -> i32 {
        let mut points = HashMap::new();
        for rect in &rectangles {
            let (x1, y1, x2, y2) = (rect[0], rect[1], rect[2], rect[3]);
            points.entry((x1, y1)).or_insert_with(Vec::new).push((x2, y2));
            points.entry((x2, y2)).or_insert_with(Vec::new).push((x1, y1));
        }

        let mut max_area = 0;
        for ((x1, y1), corners) in &points {
            for &(x2, y2) in corners {
                if x1 < x2 && y1 < y2 {
                    let width = x2 - x1;
                    let height = y2 - y1;
                    let area = width * height;
                    max_area = max_area.max(area);
                }
            }
        }

        max_area
    }
}
}