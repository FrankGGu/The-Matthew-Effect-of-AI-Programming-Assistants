impl Solution {
    pub fn max_absolute_difference(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut max_diff = 0;
        for i in 0..n {
            let j = (i + 1) % n;
            let diff = (nums[i] - nums[j]).abs();
            max_diff = max_diff.max(diff);
        }
        max_diff
    }
}