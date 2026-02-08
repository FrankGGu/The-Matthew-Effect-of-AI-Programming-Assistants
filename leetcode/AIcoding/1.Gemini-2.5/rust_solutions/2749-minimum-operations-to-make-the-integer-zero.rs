impl Solution {
    pub fn min_operations_to_make_the_integer_zero(n: i32, num2: i32) -> i32 {
        // We want to make 'n' zero by repeatedly subtracting (2^k + num2).
        // Let 'x' be the number of operations.
        // After 'x' operations, we have subtracted 'x * num2' and 'x' powers of 2.
        // So, n - x * num2 = sum(2^k_i for i=1 to x), where each k_i is a positive integer (k_i >= 1).
        // Let 'target = n - x * num2'.
        // We need to find the minimum 'x' such that 'target' can be represented as a sum of 'x' powers of 2, where each power is 2^k with k >= 1.

        // The conditions for 'target' to be representable as a sum of 'x' powers of 2 (with k >= 1) are:
        // 1. 'target' must be non-negative. (Implicitly handled by condition 2)
        // 2. 'target' must be an even number. Since all 2^k for k >= 1 are even, their sum must also be even.
        // 3. 'target' must be at least '2 * x'. This is because each 2^k for k >= 1 is at least 2^1 = 2.
        //    So, the sum of 'x' such powers must be at least '2 * x'.
        // 4. The number of set bits in 'target' (popcount) must be less than or equal to 'x'.
        //    If `popcount(target) <= x`, we can always "break down" larger powers of 2 (e.g., 2^3 = 2^2 + 2^1)
        //    to increase the number of terms until we have exactly 'x' terms, as long as 'target >= 2 * x'.
        //    (For example, 2^k can be broken into 2^(k-1) + 2^(k-1). If k=1, 2^1 cannot be broken further into 2^k for k>=1.
        //    However, the condition `target >= 2*x` ensures that we have enough "value" to form 'x' terms, each at least 2).

        // The maximum value for 'n' is 10^9, 'num2' is 10^9.
        // 'target' can be up to 10^9 - 1 * (-10^9) = 2 * 10^9.
        // The maximum number of set bits (popcount) for a number up to 2 * 10^9 is 31 (since 2^30 < 2*10^9 < 2^31).
        // If 'x' exceeds 31, then `popcount(target) <= x` will always be true.
        // Thus, we only need to check 'x' up to a small constant (e.g., 65-70) because if a solution exists,
        // it will be found within this range.

        for x in 1..=65 { // Iterate 'x' from 1 up to a safe upper bound
            let target = n as i64 - x as i64 * num2 as i64;

            // Condition 2: target must be even
            if target % 2 != 0 {
                continue;
            }

            // Condition 3: target must be at least 2 * x
            if target < 2 * x as i64 {
                // If target is too small, it's impossible to form x terms, each at least 2.
                continue;
            }

            // Condition 4: popcount(target) must be less than or equal to x
            // 'target' is guaranteed to be non-negative and even here.
            let popcount = target.count_ones();

            if popcount <= x as u32 {
                return x;
            }
        }

        -1 // No solution found within the checked range
    }
}