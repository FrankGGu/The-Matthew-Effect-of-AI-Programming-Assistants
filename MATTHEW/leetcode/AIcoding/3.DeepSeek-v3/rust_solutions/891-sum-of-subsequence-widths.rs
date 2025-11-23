impl Solution {
    pub fn sum_subseq_widths(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        let n = nums.len();
        let modulo = 1_000_000_007;
        let mut pow2 = vec![1; n];
        for i in 1..n {
            pow2[i] = (pow2[i - 1] * 2) % modulo;
        }
        let mut res = 0i64;
        for i in 0..n {
            let left = pow2[i] as i64;
            let right = pow2[n - 1 - i] as i64;
            res = (res + nums[i] as i64 * left - nums[i] as i64 * right) % modulo as i64;
        }
        res as i32
    }
}