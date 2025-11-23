impl Solution {
    pub fn sum_of_power(nums: Vec<i32>) -> i32 {
        let mod_num = 1_000_000_007;
        let mut nums = nums;
        nums.sort_unstable();
        let mut res = 0i64;
        let mut pre_sum = 0i64;
        for &num in nums.iter() {
            let x = num as i64;
            res = (res + x * x % mod_num * x % mod_num) % mod_num;
            res = (res + x * x % mod_num * pre_sum % mod_num) % mod_num;
            pre_sum = (pre_sum * 2 % mod_num + x % mod_num) % mod_num;
        }
        res as i32
    }
}