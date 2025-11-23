impl Solution {
    pub fn sum_of_digit_differences(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut total_sum = 0;

        for i in 0..10 {
            let mut sum = 0;
            for &num in &nums {
                sum += (num / 10_i32.pow(i)) % 10;
            }
            total_sum += sum * (n as i32) - sum * (n as i32);
        }

        total_sum
    }
}