impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn count_rods(s: String) -> i32 {
        let mut rings = [HashSet::new(); 3];

        for c in s.chars() {
            match c {
                'R' => rings[0].insert(1),
                'G' => rings[1].insert(1),
                'B' => rings[2].insert(1),
                _ => {}
            }
        }

        rings.iter().filter(|set| set.len() >= 1).count() as i32
    }
}
}