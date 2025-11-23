struct Solution {}

impl Solution {
    pub fn max_rotate_function(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        let mut f = 0;
        let mut sum = 0;
        for i in 0..n {
            f += nums[i] * (i as i32);
            sum += nums[i];
        }
        let mut max_f = f;
        for i in 1..n {
            f = f + sum - nums[n - i] * (n as i32);
            if f > max_f {
                max_f = f;
            }
        }
        max_f
    }
}