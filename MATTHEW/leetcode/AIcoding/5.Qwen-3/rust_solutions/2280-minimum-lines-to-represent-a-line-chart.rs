impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn min_lines(mut coordinates: Vec<Vec<i32>>) -> i32 {
        if coordinates.len() <= 1 {
            return 0;
        }

        coordinates.sort_by(|a, b| {
            match a[0].cmp(&b[0]) {
                Ordering::Equal => a[1].cmp(&b[1]),
                other => other,
            }
        });

        let mut lines = 1;
        let mut prev_diff = (coordinates[1][1] - coordinates[0][1], coordinates[1][0] - coordinates[0][0]);

        for i in 2..coordinates.len() {
            let dx = coordinates[i][0] - coordinates[i - 1][0];
            let dy = coordinates[i][1] - coordinates[i - 1][1];

            if dy * prev_diff.0 != dx * prev_diff.1 {
                lines += 1;
                prev_diff = (dy, dx);
            }
        }

        lines
    }
}
}