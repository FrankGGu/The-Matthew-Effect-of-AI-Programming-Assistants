impl Solution {
    pub fn min_difference(nums: Vec<i32>) -> i32 {
        if nums.len() <= 4 {
            return 0;
        }
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        (0..4)
            .map(|i| nums[n - 4 + i] - nums[i])
            .min()
            .unwrap()
    }
}