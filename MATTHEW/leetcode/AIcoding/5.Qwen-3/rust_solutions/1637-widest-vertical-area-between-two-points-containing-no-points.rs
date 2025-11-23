impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_width_of_vertical_area(mut points: Vec<Vec<i32>>) -> i32 {
        points.sort_by(|a, b| {
            if a[0] < b[0] {
                Ordering::Less
            } else if a[0] > b[0] {
                Ordering::Greater
            } else {
                Ordering::Equal
            }
        });
        let mut max_width = 0;
        for i in 1..points.len() {
            let width = points[i][0] - points[i - 1][0];
            if width > max_width {
                max_width = width;
            }
        }
        max_width
    }
}
}