impl Solution {
    pub fn sum_of_good_subsequences(nums: Vec<i32>) -> i32 {
        let mod_val = 1_000_000_007;
        let mut total_sum = 0;
        let mut current_sum = 0;
        let mut count = 0;

        for &num in nums.iter() {
            current_sum = (current_sum * 2 + num) % mod_val;
            total_sum = (total_sum + current_sum) % mod_val;
            count += 1;
        }

        total_sum
    }
}