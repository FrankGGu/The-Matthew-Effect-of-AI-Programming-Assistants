impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn max_area(rectangles: Vec<Vec<i32>>, points: Vec<Vec<i32>>) -> i32 {
        let mut area_map = HashMap::new();
        for rect in &rectangles {
            let x1 = rect[0];
            let y1 = rect[1];
            let x2 = rect[2];
            let y2 = rect[3];
            let area = (x2 - x1) * (y2 - y1);
            area_map.entry((x1, y1, x2, y2)).or_insert(area);
        }

        let mut max_area = 0;
        for point in &points {
            let px = point[0];
            let py = point[1];
            for ((x1, y1, x2, y2), &area) in &area_map {
                if px >= *x1 && px <= *x2 && py >= *y1 && py <= *y2 {
                    max_area = max_area.max(area);
                }
            }
        }

        max_area
    }
}
}