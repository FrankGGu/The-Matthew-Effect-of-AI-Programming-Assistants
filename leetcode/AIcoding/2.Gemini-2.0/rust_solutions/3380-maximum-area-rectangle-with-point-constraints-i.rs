use std::cmp::{max, min};

impl Solution {
    pub fn solve(points: Vec<Vec<i32>>, width: i32, height: i32) -> i32 {
        let mut max_area = 0;
        for i in 0..points.len() {
            for j in (i + 1)..points.len() {
                let x1 = points[i][0];
                let y1 = points[i][1];
                let x2 = points[j][0];
                let y2 = points[j][1];

                let left = min(x1, x2);
                let right = max(x1, x2);
                let bottom = min(y1, y2);
                let top = max(y1, y2);

                if right - left <= width && top - bottom <= height {
                    max_area = max(max_area, (right - left) * (top - bottom));
                }
            }
        }
        max_area
    }
}