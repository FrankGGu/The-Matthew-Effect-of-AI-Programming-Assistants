impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn construct_rectangle(area: i32) -> Vec<i32> {
        let mut max_side = 0;
        let mut min_side = 0;
        let area = area as usize;

        for i in 1..=((area as f64).sqrt() as usize + 1) {
            if area % i == 0 {
                max_side = area / i;
                min_side = i;
            }
        }

        vec![max_side as i32, min_side as i32]
    }
}
}