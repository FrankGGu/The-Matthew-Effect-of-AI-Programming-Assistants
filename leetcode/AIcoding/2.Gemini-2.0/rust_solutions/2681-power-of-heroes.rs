impl Solution {
    pub fn sum_of_power(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut ans: i64 = 0;
        let mut sum: i64 = 0;
        let mod_val: i64 = 1_000_000_007;

        for i in 0..n {
            let num = nums[i] as i64;
            ans = (ans + num * num % mod_val * (num + sum) % mod_val) % mod_val;
            sum = (sum * 2 % mod_val + num) % mod_val;
        }

        ans as i32
    }
}