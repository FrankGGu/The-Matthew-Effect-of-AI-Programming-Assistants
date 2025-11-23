impl Solution {

use std::cmp;

impl Solution {
    pub fn minimum_recolors(blocks: String, k: i32) -> i32 {
        let k = k as usize;
        let mut min_recolors = k;
        let mut current_recolors = 0;

        for i in 0..blocks.len() {
            if blocks.as_bytes()[i] == b'B' {
                current_recolors += 1;
            }

            if i >= k {
                if blocks.as_bytes()[i - k] == b'B' {
                    current_recolors -= 1;
                }
            }

            if i >= k - 1 {
                min_recolors = cmp::min(min_recolors, current_recolors);
            }
        }

        min_recolors as i32
    }
}
}