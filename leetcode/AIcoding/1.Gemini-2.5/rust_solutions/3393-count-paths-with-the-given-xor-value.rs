use std::collections::HashMap;

impl Solution {
    pub fn count_paths_with_given_xor_value(arr: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut current_xor_sum = 0;
        let mut freq_map: HashMap<i32, i32> = HashMap::new();

        freq_map.insert(0, 1);

        for num in arr {
            current_xor_sum ^= num;

            let target_xor_prefix = current_xor_sum ^ k;

            if let Some(&freq) = freq_map.get(&target_xor_prefix) {
                count += freq;
            }

            *freq_map.entry(current_xor_sum).or_insert(0) += 1;
        }

        count
    }
}