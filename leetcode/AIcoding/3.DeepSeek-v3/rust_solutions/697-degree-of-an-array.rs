use std::collections::HashMap;

impl Solution {
    pub fn find_shortest_sub_array(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        let mut first_occurrence = HashMap::new();
        let mut last_occurrence = HashMap::new();
        let mut max_freq = 0;

        for (i, &num) in nums.iter().enumerate() {
            let count = freq.entry(num).or_insert(0);
            *count += 1;
            max_freq = max_freq.max(*count);

            if !first_occurrence.contains_key(&num) {
                first_occurrence.insert(num, i);
            }
            last_occurrence.insert(num, i);
        }

        let mut min_len = nums.len() as i32;
        for (&num, &count) in freq.iter() {
            if count == max_freq {
                let len = last_occurrence[&num] - first_occurrence[&num] + 1;
                min_len = min_len.min(len as i32);
            }
        }

        min_len
    }
}