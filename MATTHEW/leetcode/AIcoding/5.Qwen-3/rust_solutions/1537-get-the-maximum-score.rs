impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_score(mut s: String, mut t: String) -> i32 {
        let mut i = 0;
        let mut j = 0;
        let mut score = 0;

        while i < s.len() && j < t.len() {
            if s.chars().nth(i) == t.chars().nth(j) {
                score += 1;
                i += 1;
                j += 1;
            } else {
                match s.chars().nth(i).cmp(&t.chars().nth(j)) {
                    Ordering::Less => i += 1,
                    _ => j += 1,
                }
            }
        }

        score
    }
}
}