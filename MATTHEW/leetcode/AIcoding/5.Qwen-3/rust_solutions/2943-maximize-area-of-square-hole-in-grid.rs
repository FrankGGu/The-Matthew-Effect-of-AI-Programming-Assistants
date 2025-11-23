impl Solution {

use std::cmp::max;

struct Solution;

impl Solution {
    pub fn maximize_square_hole_area(n: i32, m: i32, hoc: Vec<Vec<i32>>, vpc: Vec<Vec<i32>>) -> i32 {
        let mut horizontal = vec![0; n as usize + 1];
        let mut vertical = vec![0; m as usize + 1];

        for i in 0..hoc.len() {
            horizontal[hoc[i][0] as usize] = hoc[i][1];
        }

        for i in 0..vpc.len() {
            vertical[vpc[i][0] as usize] = vpc[i][1];
        }

        let mut max_gap = 0;
        let mut current_gap = 0;

        for i in 1..=n {
            if horizontal[i as usize] == 0 {
                current_gap += 1;
            } else {
                max_gap = max(max_gap, current_gap);
                current_gap = 0;
            }
        }
        max_gap = max(max_gap, current_gap);

        current_gap = 0;

        for i in 1..=m {
            if vertical[i as usize] == 0 {
                current_gap += 1;
            } else {
                max_gap = max(max_gap, current_gap);
                current_gap = 0;
            }
        }
        max_gap = max(max_gap, current_gap);

        max_gap * max_gap
    }
}
}