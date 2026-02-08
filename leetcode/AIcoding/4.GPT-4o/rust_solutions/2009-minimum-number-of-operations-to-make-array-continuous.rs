impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut min_ops = n as i32;

        for i in 0..n {
            let upper_bound = nums[i] + n as i32 - 1;
            let mut j = 0;

            while j < n && nums[j] <= upper_bound {
                j += 1;
            }

            min_ops = min_ops.min(n as i32 - j as i32);
        }

        min_ops
    }
}