use std::collections::HashMap;

impl Solution {
    pub fn sum_distinct_element_squares(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let modulo: i64 = 1_000_000_007;

        let mut last_pos: HashMap<i32, i32> = HashMap::new();

        let mut current_sum_of_squares_ending_at_i: i64 = 0;
        let mut total_sum_of_squares: i64 = 0;

        for i in 0..n {
            let val = nums[i];
            let val_i64 = val as i64;

            let p = *last_pos.get(&val).unwrap_or(&-1);

            let count_new_occurrences = (i as i64 - p as i64);

            let val_sq = (val_i64 * val_i64) % modulo;

            let term_contribution = (count_new_occurrences * val_sq) % modulo;

            current_sum_of_squares_ending_at_i = (current_sum_of_squares_ending_at_i + term_contribution) % modulo;

            total_sum_of_squares = (total_sum_of_squares + current_sum_of_squares_ending_at_i) % modulo;

            last_pos.insert(val, i as i32);
        }

        total_sum_of_squares as i32
    }
}