impl Solution {
    pub fn max_sequence_value(arr: Vec<i32>) -> i32 {
        let mut max_value = 0;
        let mut current_sum = 0;

        for &num in &arr {
            current_sum += num;
            if current_sum > max_value {
                max_value = current_sum;
            }
            if current_sum < 0 {
                current_sum = 0;
            }
        }

        max_value
    }
}