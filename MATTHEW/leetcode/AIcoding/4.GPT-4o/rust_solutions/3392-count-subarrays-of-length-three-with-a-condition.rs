impl Solution {
    pub fn count_subarrays(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let n = nums.len();

        for i in 0..n - 2 {
            if nums[i] < nums[i + 1] && nums[i + 1] > nums[i + 2] {
                count += 1;
            }
        }

        count
    }
}