impl Solution {
    pub fn zero_filled_subarrays(nums: Vec<i32>) -> i64 {
        let mut total_subarrays: i64 = 0;
        let mut current_consecutive_zeros: i64 = 0;

        for num in nums {
            if num == 0 {
                current_consecutive_zeros += 1;
            } else {
                total_subarrays += current_consecutive_zeros * (current_consecutive_zeros + 1) / 2;
                current_consecutive_zeros = 0;
            }
        }

        total_subarrays += current_consecutive_zeros * (current_consecutive_zeros + 1) / 2;

        total_subarrays
    }
}