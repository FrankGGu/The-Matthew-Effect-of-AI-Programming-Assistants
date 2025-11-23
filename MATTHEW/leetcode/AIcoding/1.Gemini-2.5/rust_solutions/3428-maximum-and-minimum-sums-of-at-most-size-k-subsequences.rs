impl Solution {
    pub fn sums_of_subsequences(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();

        let n = nums.len();
        let k = k as usize;
        let modulo = 1_000_000_007;

        // Precompute powers of 2 modulo. pow2[i] = 2^i % modulo.
        let mut pow2 = vec![1; n + 1];
        for i in 1..=n {
            pow2[i] = (pow2[i - 1] * 2) % modulo;
        }

        let mut total_sum: i64 = 0;

        for i in 0..n {
            let num = nums[i] as i64;

            // Calculate contribution when nums[i] is the maximum element.
            // nums[i] is max, nums[j] is min (j <= i).
            // The length of the subsequence [nums[j], ..., nums[i]] must be at most k.
            // Length is (i - j + 1). So (i - j + 1) <= k => j >= i - k + 1.
            // So j ranges from max(0, i - k + 1) to i.
            // For each such j, we can pick any subset of elements between nums[j+1] and nums[i-1].
            // The number of elements between them is (i - j - 1).
            // Since (i - j + 1) <= k, it implies (i - j - 1) <= k - 2.
            // So we can pick any subset of these (i - j - 1) elements.
            // The number of ways is 2^(i - j - 1). (If i=j, this is 2^-1, which is 1).
            // The sum of 2^(i - j - 1) for j from max(0, i - k + 1) to i-1, plus 1 for j=i.
            // This sum simplifies to 2^(i - max(0, i - k + 1)).
            // The exponent is `i - max(0, i - k + 1)`.
            // If `i - k + 1 <= 0`, exponent is `i`.
            // If `i - k + 1 > 0`, exponent is `i - (i - k + 1) = k - 1`.
            // So, the exponent is `min(i, k - 1)`.
            let max_exponent = (i as i32).min(k as i32 - 1) as usize;
            let max_contrib_count = pow2[max_exponent];

            // Calculate contribution when nums[i] is the minimum element.
            // nums[i] is min, nums[j] is max (j >= i).
            // The length of the subsequence [nums[i], ..., nums[j]] must be at most k.
            // Length is (j - i + 1). So (j - i + 1) <= k => j <= i + k - 1.
            // So j ranges from i to min(n - 1, i + k - 1).
            // For each such j, we can pick any subset of elements between nums[i+1] and nums[j-1].
            // The number of elements between them is (j - i - 1).
            // Since (j - i + 1) <= k, it implies (j - i - 1) <= k - 2.
            // So we can pick any subset of these (j - i - 1) elements.
            // The number of ways is 2^(j - i - 1). (If i=j, this is 2^-1, which is 1).
            // The sum of 2^(j - i - 1) for j from i+1 to min(n-1, i+k-1), plus 1 for j=i.
            // This sum simplifies to 2^(min(n-1, i+k-1) - i).
            // The exponent is `min(n - 1, i + k - 1) - i`.
            // If `i + k - 1 >= n - 1`, exponent is `(n - 1) - i`.
            // If `i + k - 1 < n - 1`, exponent is `(i + k - 1) - i = k - 1`.
            // So, the exponent is `min(n - 1 - i, k - 1)`.
            let min_exponent = ((n - 1 - i) as i32).min(k as i32 - 1) as usize;
            let min_contrib_count = pow2[min_exponent];

            let term = (num * (max_contrib_count + min_contrib_count)) % modulo;
            total_sum = (total_sum + term) % modulo;
        }

        total_sum as i32
    }
}