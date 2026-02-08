use std::collections::HashMap;

impl Solution {
    pub fn sum_of_distances(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut count = vec![0; n];
        let mut sum = vec![0; n];
        let mut result = vec![0; n];
        let mut index_map: HashMap<i32, Vec<usize>> = HashMap::new();

        for (i, &num) in nums.iter().enumerate() {
            index_map.entry(num).or_insert(Vec::new()).push(i);
        }

        for indices in index_map.values() {
            let k = indices.len();
            let mut prefix_sum = 0;

            for &index in indices {
                prefix_sum += index as i32;
            }

            for &index in indices {
                let left_count = (index as i32) * (k as i32) - prefix_sum;
                let right_count = prefix_sum - (index as i32) * (k as i32 - 1);
                result[index] += left_count + right_count;
            }
        }

        result
    }
}