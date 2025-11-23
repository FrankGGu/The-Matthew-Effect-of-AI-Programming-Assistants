impl Solution {
    pub fn count_good_subarrays(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        for i in 0..nums.len() - 2 {
            if (nums[i] == nums[i + 1] && nums[i] != nums[i + 2]) ||
               (nums[i] == nums[i + 2] && nums[i] != nums[i + 1]) ||
               (nums[i + 1] == nums[i + 2] && nums[i] != nums[i + 1]) {
                count += 1;
            }
        }
        count
    }
}