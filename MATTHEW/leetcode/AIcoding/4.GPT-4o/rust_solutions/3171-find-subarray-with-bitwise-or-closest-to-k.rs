impl Solution {
    pub fn find_best_subarray(nums: Vec<i32>, k: i32) -> Vec<i32> {
        use std::collections::HashMap;

        let mut closest = i32::MAX;
        let mut best_subarray = Vec::new();
        let mut prefix_or = vec![0; nums.len() + 1];
        let mut map: HashMap<i32, usize> = HashMap::new();

        for i in 0..nums.len() {
            prefix_or[i + 1] = prefix_or[i] | nums[i];
        }

        for i in 0..nums.len() {
            for j in i..nums.len() {
                let current_or = prefix_or[j + 1] ^ prefix_or[i];
                let diff = (current_or - k).abs();
                if diff < closest {
                    closest = diff;
                    best_subarray = nums[i..=j].to_vec();
                }
            }
        }

        best_subarray
    }
}