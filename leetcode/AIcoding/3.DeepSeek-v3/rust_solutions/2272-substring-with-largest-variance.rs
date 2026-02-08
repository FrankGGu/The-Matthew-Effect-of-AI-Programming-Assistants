use std::cmp::{max, min};

impl Solution {
    pub fn largest_variance(s: String) -> i32 {
        let mut counter = vec![0; 26];
        for c in s.chars() {
            counter[(c as u8 - b'a') as usize] += 1;
        }

        let mut global_max = 0;

        for a in 0..26 {
            for b in 0..26 {
                if a == b || counter[a] == 0 || counter[b] == 0 {
                    continue;
                }

                let mut count_a = 0;
                let mut count_b = 0;
                let mut remaining_b = counter[b];

                for c in s.chars() {
                    let idx = (c as u8 - b'a') as usize;
                    if idx == a {
                        count_a += 1;
                    } else if idx == b {
                        count_b += 1;
                        remaining_b -= 1;
                    }

                    if count_b > 0 {
                        global_max = max(global_max, count_a - count_b);
                    }

                    if count_a < count_b && remaining_b > 0 {
                        count_a = 0;
                        count_b = 0;
                    }
                }
            }
        }

        global_max
    }
}