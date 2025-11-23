struct Solution;

impl Solution {
    pub fn find_sum_of_array_product_of_magical_sequences(nums: Vec<i32>) -> i32 {
        let modulo = 1_000_000_007;
        let mut total_sum: i64 = 0;

        for &num in nums.iter() {
            let n_i64 = num as i64;

            let term_one_plus_total_sum = (1 + total_sum) % modulo;

            let mut new_contributions = (n_i64 * term_one_plus_total_sum) % modulo;

            if new_contributions < 0 {
                new_contributions += modulo;
            }

            total_sum = (total_sum + new_contributions) % modulo;

            if total_sum < 0 {
                total_sum += modulo;
            }
        }

        total_sum as i32
    }
}