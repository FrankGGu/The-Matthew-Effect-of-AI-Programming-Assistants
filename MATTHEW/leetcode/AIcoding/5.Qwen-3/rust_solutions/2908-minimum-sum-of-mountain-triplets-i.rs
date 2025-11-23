impl Solution {
    pub fn minimum_sum(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut min_sum = i32::MAX;

        for i in 1..n-1 {
            if nums[i-1] < nums[i] && nums[i] > nums[i+1] {
                min_sum = std::cmp::min(min_sum, nums[i-1] + nums[i] + nums[i+1]);
            }
        }

        if min_sum == i32::MAX {
            -1
        } else {
            min_sum
        }
    }
}