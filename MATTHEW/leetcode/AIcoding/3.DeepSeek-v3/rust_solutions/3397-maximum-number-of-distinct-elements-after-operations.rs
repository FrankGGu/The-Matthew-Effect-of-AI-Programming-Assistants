use std::collections::HashMap;

impl Solution {
    pub fn maximum_distinct_elements(nums: Vec<i32>, k: i32) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut duplicates = Vec::new();
        let mut distinct = 0;
        for (_, &count) in freq.iter() {
            if count == 1 {
                distinct += 1;
            } else {
                duplicates.push(count);
            }
        }

        duplicates.sort();
        let mut k = k;
        for &count in &duplicates {
            let needed = count - 1;
            if k >= needed {
                k -= needed;
                distinct += 1;
            } else {
                return distinct + k;
            }
        }

        distinct - k.max(0)
    }
}