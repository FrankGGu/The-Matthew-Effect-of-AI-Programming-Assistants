impl Solution {
    pub fn count_fair_pairs(nums: Vec<i32>, lower: i32, upper: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut count = 0;
        let n = nums.len();
        for i in 0..n {
            let target_low = lower - nums[i];
            let target_high = upper - nums[i];
            let low_index = nums.binary_search(&target_low).unwrap_or_else(|x| x);
            let high_index = nums.binary_search(&target_high).unwrap_or_else(|x| x);
            count += (high_index - low_index) as i32;
            if target_low <= nums[i] && target_high >= nums[i] {
                count -= 1;
            }
        }
        count / 2
    }
}