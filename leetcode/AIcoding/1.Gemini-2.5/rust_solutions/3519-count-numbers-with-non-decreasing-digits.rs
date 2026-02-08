impl Solution {
    fn combinations(n: i64, k: i64) -> i64 {
        if k < 0 || k > n {
            return 0;
        }
        if k == 0 || k == n {
            return 1;
        }
        // Optimization: C(n, k) = C(n, n - k)
        let k = k.min(n - k);

        let mut res = 1;
        for i in 0..k {
            res = res * (n - i) / (i + 1);
        }
        res
    }

    pub fn count_numbers_with_non_decreasing_digits(n: i32) -> i32 {
        let mut total_count: i64 = 0;

        // Iterate through the number of digits, from 1 up to n.
        // For each number of digits `k_digits`, we count numbers
        // with `k_digits` that have non-decreasing digits and no leading zero.
        // This is equivalent to choosing `k_digits` digits from {1, 2, ..., 9} with replacement,
        // and arranging them in non-decreasing order.
        // Using stars and bars, this is C(k_digits + 9 - 1, k_digits) = C(k_digits + 8, k_digits).
        // Since C(N, K) = C(N, N-K), we can use C(k_digits + 8, 8) for efficiency.
        for k_digits in 1..=n {
            total_count += Self::combinations(k_digits as i64 + 8, 8);
        }

        // Add 1 for the number 0, which is also considered to have non-decreasing digits.
        total_count += 1;

        total_count as i32
    }
}