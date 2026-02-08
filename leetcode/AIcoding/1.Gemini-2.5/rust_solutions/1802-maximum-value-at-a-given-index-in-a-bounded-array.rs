impl Solution {
    pub fn max_value(n: i32, index: i32, max_sum: i32) -> i32 {
        let n_i64 = n as i64;
        let index_i64 = index as i64;
        let max_sum_i64 = max_sum as i64;

        let mut low: i64 = 1;
        let mut high: i64 = max_sum_i64;
        let mut ans: i64 = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::check(mid, n_i64, index_i64, max_sum_i64) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        ans as i32
    }

    fn get_sum_side(peak_val: i64, num_elements_on_side: i64) -> i64 {
        if num_elements_on_side == 0 {
            return 0;
        }

        if peak_val - 1 >= num_elements_on_side {
            let first_term = peak_val - 1;
            let last_term = peak_val - num_elements_on_side;
            num_elements_on_side * (first_term + last_term) / 2
        } else {
            let sum_decreasing_part = (peak_val - 1) * peak_val / 2;
            let sum_ones_part = num_elements_on_side - (peak_val - 1);
            sum_decreasing_part + sum_ones_part
        }
    }

    fn check(k: i64, n: i64, index: i64, max_sum: i64) -> bool {
        let left_sum = Self::get_sum_side(k, index);
        let right_sum = Self::get_sum_side(k, n - 1 - index);

        let total_sum = k + left_sum + right_sum;
        total_sum <= max_sum
    }
}