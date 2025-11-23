impl Solution {
    pub fn k_concatenation_max_sum(arr: Vec<i32>, k: i32) -> i32 {
        let modulo = 1_000_000_007;
        let n = arr.len();
        let mut max_subarray_sum = 0;
        let mut current_max = 0;
        let mut total_sum = 0;

        for &num in &arr {
            current_max = std::cmp::max(0, current_max + num as i64);
            max_subarray_sum = std::cmp::max(max_subarray_sum, current_max);
            total_sum += num as i64;
        }

        if k == 1 {
            return (max_subarray_sum % modulo as i64) as i32;
        }

        let mut max_prefix_sum = 0;
        let mut current_prefix_sum = 0;
        for &num in &arr {
            current_prefix_sum += num as i64;
            max_prefix_sum = std::cmp::max(max_prefix_sum, current_prefix_sum);
        }

        let mut max_suffix_sum = 0;
        let mut current_suffix_sum = 0;
        for &num in arr.iter().rev() {
            current_suffix_sum += *num as i64;
            max_suffix_sum = std::cmp::max(max_suffix_sum, current_suffix_sum);
        }

        let mut result = max_subarray_sum;
        if total_sum > 0 {
            result = std::cmp::max(result, max_prefix_sum + max_suffix_sum + total_sum * (k as i64 - 2));
        } else {
            result = std::cmp::max(result, max_prefix_sum + max_suffix_sum);
        }

        (result % modulo as i64) as i32
    }
}

struct Solution;