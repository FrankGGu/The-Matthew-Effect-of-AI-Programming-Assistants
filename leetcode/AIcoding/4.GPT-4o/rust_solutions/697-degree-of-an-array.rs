use std::collections::HashMap;

impl Solution {
    pub fn find_shortest_subarray(nums: Vec<i32>) -> i32 {
        let mut first_index = HashMap::new();
        let mut count = HashMap::new();
        let mut degree = 0;

        for (i, &num) in nums.iter().enumerate() {
            first_index.entry(num).or_insert(i);
            let entry = count.entry(num).or_insert(0);
            *entry += 1;
            degree = degree.max(*entry);
        }

        let mut min_length = nums.len() as i32;
        for (&num, &cnt) in count.iter() {
            if cnt == degree {
                let length = (nums.len() - first_index[num]) as i32 - (first_index[num] as i32);
                min_length = min_length.min(length + 1);
            }
        }

        min_length
    }
}