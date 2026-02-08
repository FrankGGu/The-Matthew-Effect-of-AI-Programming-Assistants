impl Solution {
    pub fn max_alternating_sum(nums: Vec<i32>) -> i64 {
        let mut max_sum_ending_with_plus: i64 = 0; // Represents the maximum alternating subsequence sum ending with a positive term.
        let mut max_sum_ending_with_minus: i64 = 0; // Represents the maximum alternating subsequence sum ending with a negative term.

        for num in nums {
            let n = num as i64;

            // Calculate the new maximum sum ending with a positive term.
            // This can be achieved in two ways:
            // 1. By not including the current number 'n' as a positive term. In this case, the sum remains 'max_sum_ending_with_plus' from the previous iteration.
            // 2. By including the current number 'n' as a positive term. This 'n' must follow a negative term.
            //    So, we take the 'max_sum_ending_with_minus' (from previous iteration) and add 'n'.
            let new_max_sum_ending_with_plus = max_sum_ending_with_plus.max(max_sum_ending_with_minus + n);

            // Calculate the new maximum sum ending with a negative term.
            // This can be achieved in two ways:
            // 1. By not including the current number 'n' as a negative term. In this case, the sum remains 'max_sum_ending_with_minus' from the previous iteration.
            // 2. By including the current number 'n' as a negative term. This 'n' must follow a positive term.
            //    So, we take the 'max_sum_ending_with_plus' (from previous iteration) and subtract 'n'.
            let new_max_sum_ending_with_minus = max_sum_ending_with_minus.max(max_sum_ending_with_plus - n);

            max_sum_ending_with_plus = new_max_sum_ending_with_plus;
            max_sum_ending_with_minus = new_max_sum_ending_with_minus;
        }

        // The maximum alternating sum will always be found in 'max_sum_ending_with_plus'.
        // If an optimal subsequence ends with a negative term (... + X - Y), its sum is S.
        // If we simply drop the last negative term (... + X), its sum is S + Y. Since Y >= 1, S + Y > S.
        // Therefore, we can always achieve a greater or equal sum by ending with a positive term or by not including a negative term that would reduce the sum.
        max_sum_ending_with_plus
    }
}