impl Solution {
    pub fn find_k_distant_indices(nums: Vec<i32>, key: i32, k: i32) -> Vec<i32> {
        let n = nums.len();
        let mut result = Vec::new();

        for i in 0..n {
            if nums[i] == key {
                let start = if i as i32 - k < 0 { 0 } else { i as i32 - k };
                let end = if i as i32 + k >= n as i32 { n as i32 - 1 } else { i as i32 + k };
                for j in start..=end {
                    if !result.contains(&(j as i32)) {
                        result.push(j as i32);
                    }
                }
            }
        }

        result.sort();
        result
    }
}