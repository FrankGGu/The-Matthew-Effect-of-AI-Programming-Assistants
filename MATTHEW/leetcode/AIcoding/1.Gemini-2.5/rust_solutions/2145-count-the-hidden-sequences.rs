impl Solution {
    pub fn number_of_hidden_sequences(differences: Vec<i32>, lower: i32, upper: i32) -> i32 {
        let mut min_prefix_sum: i64 = 0;
        let mut max_prefix_sum: i64 = 0;
        let mut current_prefix_sum: i64 = 0;

        for &diff in differences.iter() {
            current_prefix_sum += diff as i64;
            min_prefix_sum = min_prefix_sum.min(current_prefix_sum);
            max_prefix_sum = max_prefix_sum.max(current_prefix_sum);
        }

        let min_b0_lower_bound = lower as i64 - min_prefix_sum;
        let max_b0_upper_bound = upper as i64 - max_prefix_sum;

        let count = max_b0_upper_bound - min_b0_lower_bound + 1;

        if count < 0 {
            0
        } else {
            count as i32
        }
    }
}