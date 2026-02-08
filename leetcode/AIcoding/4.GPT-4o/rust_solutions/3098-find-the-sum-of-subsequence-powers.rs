impl Solution {
    pub fn sum_of_subsequence_powers(nums: Vec<i32>) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = nums.len();
        let mut result = 0;
        let mut power_of_two = 1;

        let mut nums = nums;
        nums.sort_unstable();

        for num in nums.iter().rev() {
            result = (result + num * power_of_two) % MOD;
            power_of_two = (power_of_two * 2) % MOD;
        }

        result
    }
}