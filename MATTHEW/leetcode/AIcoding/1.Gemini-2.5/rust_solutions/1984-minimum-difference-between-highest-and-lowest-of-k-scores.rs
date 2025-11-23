impl Solution {
    pub fn minimum_difference(mut nums: Vec<i32>, k: i32) -> i32 {
        nums.sort_unstable();
        let k = k as usize;
        let mut min_diff = std::i32::MAX;

        for i in 0..=nums.len() - k {
            let diff = nums[i + k - 1] - nums[i];
            if diff < min_diff {
                min_diff = diff;
            }
        }
        min_diff
    }
}