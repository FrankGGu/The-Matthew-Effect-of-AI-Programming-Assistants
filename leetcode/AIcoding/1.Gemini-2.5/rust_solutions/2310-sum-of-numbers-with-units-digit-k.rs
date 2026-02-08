impl Solution {
    pub fn sum_numbers_with_units_digit_k(num: i32, k: i32) -> i32 {
        if num == 0 {
            return 0;
        }

        let num_unit_digit = num % 10;

        for m in 1..=num {
            // The sum of m numbers, each ending in k, will have a units digit of (m * k) % 10.
            // We need this to match the units digit of num.
            if (m * k) % 10 == num_unit_digit {
                // Also, the sum of m positive integers, each ending in k, must be at least m*k.
                // If k is 0, the smallest positive integer ending in 0 is 10.
                // So, if k=0, the sum must be at least m*10.
                // However, the problem statement says "positive integers".
                // If k=0, the smallest positive integer is 10. So x_i >= 10.
                // If k > 0, the smallest positive integer is k. So x_i >= k.
                // In general, x_i >= k if k > 0.
                // If k = 0, x_i >= 10.
                // The condition `m * k <= num` effectively checks if `num - m * k >= 0`.
                // If `num - m * k` is non-negative and its units digit is 0 (which is implied by `(m*k)%10 == num_unit_digit`),
                // then `num - m * k` is a non-negative multiple of 10.
                // This means `num - m * k = 10 * S` for some integer `S >= 0`.
                // We can write each `x_i = 10 * a_i + k`.
                // Sum(x_i) = 10 * Sum(a_i) + m * k = num.
                // So, 10 * Sum(a_i) = num - m * k.
                // If `num - m * k` is a non-negative multiple of 10, we can always find non-negative integers `a_i` that sum to `(num - m * k) / 10`.
                // For example, set `a_1 = (num - m * k) / 10` and `a_j = 0` for `j > 1`.
                // This ensures `x_i` are positive if `k > 0` (smallest is `k`).
                // If `k = 0`, then `x_i = 10 * a_i`. We need `a_i >= 1` for `x_i` to be positive.
                // But `num - m * k = 10 * Sum(a_i)`. If `k=0`, `num = 10 * Sum(a_i)`.
                // If `num - m * k >= 0` and `(num - m * k) % 10 == 0`, then `num - m * k` is a non-negative multiple of 10.
                // This is sufficient.
                if m * k <= num {
                    return m;
                }
            }
        }

        -1
    }
}