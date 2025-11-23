impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn largest_variance(s: String) -> i32 {
        let mut max_variance = 0;
        let chars: Vec<char> = s.chars().collect();
        let unique_chars: Vec<char> = chars.iter().cloned().collect::<std::collections::HashSet<_>>().into_iter().collect();

        for a in &unique_chars {
            for b in &unique_chars {
                if a == b {
                    continue;
                }
                let mut has_b = false;
                let mut count_a = 0;
                let mut count_b = 0;
                let mut max_var = 0;
                let mut reset = false;

                for c in &chars {
                    if *c == *a {
                        count_a += 1;
                    } else if *c == *b {
                        count_b += 1;
                        has_b = true;
                    }

                    if count_b > count_a {
                        reset = true;
                        count_a = 0;
                        count_b = 0;
                    }

                    if has_b && reset {
                        max_var = std::cmp::max(max_var, count_a - count_b);
                        reset = false;
                    }
                }

                if has_b {
                    max_variance = std::cmp::max(max_variance, max_var);
                }
            }
        }

        max_variance
    }
}

struct Solution {}
}