impl Solution {
    pub fn left_and_right_sum_differences(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        if n == 0 {
            return Vec::new();
        }

        let total_sum: i32 = nums.iter().sum();
        let mut answer = vec![0; n];

        let mut current_left_sum = 0;
        let mut current_right_sum = total_sum;

        for i in 0..n {
            current_right_sum -= nums[i];

            answer[i] = (current_left_sum - current_right_sum).abs();

            current_left_sum += nums[i];
        }

        answer
    }
}