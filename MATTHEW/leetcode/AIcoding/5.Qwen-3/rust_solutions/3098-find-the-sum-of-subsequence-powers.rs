struct Solution;

impl Solution {
    pub fn sum_of_subsequence_powers(nums: Vec<i32>, m: i32) -> i32 {
        let mod_val = 10_i64.pow(9) + 7;
        let mut result = 0_i64;
        let n = nums.len();

        for i in 0..n {
            let mut power = 1_i64;
            for j in i..n {
                power = (power * nums[j] as i64) % mod_val;
                result = (result + power) % mod_val;
            }
        }

        result as i32
    }
}