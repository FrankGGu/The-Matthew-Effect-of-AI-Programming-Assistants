use std::collections::HashMap;

impl Solution {
    pub fn find_shortest_sub_array(nums: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        let mut first_occurrence: HashMap<i32, usize> = HashMap::new();
        let mut last_occurrence: HashMap<i32, usize> = HashMap::new();

        for (i, &num) in nums.iter().enumerate() {
            *counts.entry(num).or_insert(0) += 1;
            first_occurrence.entry(num).or_insert(i);
            last_occurrence.insert(num, i);
        }

        let mut degree = 0;
        for &count in counts.values() {
            if count > degree {
                degree = count;
            }
        }

        let mut min_length = nums.len() as i32;

        for (&num, &count) in counts.iter() {
            if count == degree {
                let length = (last_occurrence[&num] - first_occurrence[&num] + 1) as i32;
                if length < min_length {
                    min_length = length;
                }
            }
        }

        min_length
    }
}