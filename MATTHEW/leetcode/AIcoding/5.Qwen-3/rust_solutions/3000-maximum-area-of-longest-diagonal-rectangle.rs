impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn area_iq(rectangles: Vec<Vec<i32>>) -> i32 {
        let mut max_diag = 0;
        let mut max_area = 0;

        for rect in rectangles {
            let x = rect[0];
            let y = rect[1];
            let diag = x * x + y * y;
            let area = x * y;

            match diag.cmp(&max_diag) {
                Ordering::Greater => {
                    max_diag = diag;
                    max_area = area;
                },
                Ordering::Equal => {
                    max_area = std::cmp::max(max_area, area);
                },
                _ => {}
            }
        }

        max_area
    }
}
}