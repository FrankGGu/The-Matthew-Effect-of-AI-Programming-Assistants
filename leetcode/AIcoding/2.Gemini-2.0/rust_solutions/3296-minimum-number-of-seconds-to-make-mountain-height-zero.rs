use std::collections::HashMap;

impl Solution {
    pub fn minimum_seconds(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut first_occurrence: HashMap<i32, usize> = HashMap::new();
        let mut last_occurrence: HashMap<i32, usize> = HashMap::new();

        for i in 0..n {
            if !first_occurrence.contains_key(&nums[i]) {
                first_occurrence.insert(nums[i], i);
            }
            last_occurrence.insert(nums[i], i);
        }

        let mut counts: HashMap<i32, i32> = HashMap::new();
        for i in 0..n {
            *counts.entry(nums[i]).or_insert(0) += 1;
        }

        let mut max_count = 0;
        for &count in counts.values() {
            max_count = max_count.max(count);
        }

        let mut best = max_count;

        for (&num, _) in &counts {
            let first = first_occurrence[&num];
            let last = last_occurrence[&num];

            let len = if first <= last {
                last - first + 1
            } else {
                n - first + last + 1
            };

            best = best.min((len + 1) / 2);
        }

        best
    }
}