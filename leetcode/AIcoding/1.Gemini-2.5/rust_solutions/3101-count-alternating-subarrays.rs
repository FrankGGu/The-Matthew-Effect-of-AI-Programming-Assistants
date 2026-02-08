impl Solution {
    pub fn count_alternating_subarrays(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        let mut total_alternating_subarrays: i64 = 0;
        let mut current_alternating_length: i64 = 0;

        for i in 0..n {
            if i == 0 {
                current_alternating_length = 1;
            } else {
                if nums[i] != nums[i - 1] {
                    current_alternating_length += 1;
                } else {
                    current_alternating_length = 1;
                }
            }
            total_alternating_subarrays += current_alternating_length;
        }

        total_alternating_subarrays
    }
}