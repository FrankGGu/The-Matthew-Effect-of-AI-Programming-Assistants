use std::collections::HashMap;

impl Solution {
    pub fn max_distinct_elements(nums: Vec<i32>, k: i32) -> i32 {
        let mut counts = HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut freq = vec![];
        for &count in counts.values() {
            freq.push(count);
        }

        freq.sort();

        let mut k_left = k;
        let mut distinct_count = freq.len() as i32;

        for &f in &freq {
            if f == 1 {
                continue;
            }
            let needed = f - 1;
            if k_left >= needed {
                k_left -= needed;
            } else {
                break;
            }
            distinct_count -= 1;
        }

        for &f in &freq {
            if f == 1 {
                if k_left > 0 {
                    distinct_count -= 1;
                    k_left -= 1;
                }
            }
        }

        distinct_count + k_left.min(0)
    }
}