use std::collections::HashMap;

impl Solution {
    pub fn num_of_pairs(nums: Vec<String>, target: String) -> i32 {
        let mut freq_map: HashMap<String, i32> = HashMap::new();
        for s in &nums {
            *freq_map.entry(s.clone()).or_insert(0) += 1;
        }

        let mut count = 0;
        for s1 in &nums {
            let len1 = s1.len();

            if len1 >= target.len() {
                continue;
            }

            if target.starts_with(s1) {
                let s2_needed = &target[len1..];

                if let Some(&freq_s2) = freq_map.get(s2_needed) {
                    if s1 == s2_needed {
                        count += freq_s2 - 1;
                    } else {
                        count += freq_s2;
                    }
                }
            }
        }

        count
    }
}