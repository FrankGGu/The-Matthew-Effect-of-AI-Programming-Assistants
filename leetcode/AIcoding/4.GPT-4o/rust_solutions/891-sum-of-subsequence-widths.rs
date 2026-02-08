impl Solution {
    pub fn sum_subseq_widths(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut res = 0;
        let n = nums.len();
        let mod_val = 1_000_000_007;
        let mut pow2 = 1;

        for i in 0..n {
            res = (res + (nums[i] as i64 * pow2) % mod_val) % mod_val;
            res = (res - (nums[n - 1 - i] as i64 * pow2) % mod_val + mod_val) % mod_val;
            pow2 = (pow2 * 2) % mod_val;
        }

        res as i32
    }
}