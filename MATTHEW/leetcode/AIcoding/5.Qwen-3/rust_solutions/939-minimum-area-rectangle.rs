impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn min_area_rectangle(mut coordinates: Vec<Vec<i32>>) -> i32 {
        let mut points = HashSet::new();
        for coord in &coordinates {
            points.insert((coord[0], coord[1]));
        }

        let mut min_area = i32::MAX;
        for i in 0..coordinates.len() {
            for j in i + 1..coordinates.len() {
                let (x1, y1) = (coordinates[i][0], coordinates[i][1]);
                let (x2, y2) = (coordinates[j][0], coordinates[j][1]);
                if x1 != x2 && y1 != y2 {
                    if points.contains(&(x1, y2)) && points.contains(&(x2, y1)) {
                        let area = (x1 - x2).abs() * (y1 - y2).abs();
                        min_area = min_area.min(area);
                    }
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
}