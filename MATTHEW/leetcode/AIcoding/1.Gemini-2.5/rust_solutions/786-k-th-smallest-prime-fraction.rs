impl Solution {
    pub fn kth_smallest_prime_fraction(arr: Vec<i32>, k: i32) -> Vec<i32> {
        let n = arr.len();
        let k = k as usize;

        let mut low = 0.0;
        let mut high = 1.0;

        let mut ans_p = 0;
        let mut ans_q = 1;

        // Perform binary search for a fixed number of iterations to ensure precision.
        // 100 iterations are generally sufficient for f64 binary search problems.
        for _ in 0..100 {
            let mid = (low + high) / 2.0;

            let mut count = 0; // Number of fractions <= mid
            let mut max_fraction_p = 0;
            let mut max_fraction_q = 1;

            let mut i = 0; // Pointer for numerator arr[i]
            for j in 1..n { // Pointer for denominator arr[j]
                // Move 'i' forward as long as arr[i] / arr[j] <= mid
                // This is equivalent to arr[i] <= mid * arr[j]
                while i < j && (arr[i] as f64) <= mid * (arr[j] as f64) {
                    // If arr[i]/arr[j] is larger than the current largest fraction found that is <= mid
                    // Use cross-multiplication for precise integer comparison: arr[i] * max_fraction_q > max_fraction_p * arr[j]
                    if (arr[i] * max_fraction_q) > (max_fraction_p * arr[j]) {
                        max_fraction_p = arr[i];
                        max_fraction_q = arr[j];
                    }
                    i += 1;
                }
                // At this point, arr[0]...arr[i-1] are all valid numerators for arr[j]
                // such that arr[x]/arr[j] <= mid.
                count += i;
            }

            if count >= k {
                // If there are 'k' or more fractions less than or equal to 'mid',
                // it means 'mid' is a possible value for the K-th smallest fraction,
                // or 'mid' is too high. We record the largest fraction found (max_fraction_p/max_fraction_q)
                // as a candidate for the K-th smallest, and try to find a smaller 'mid'.
                ans_p = max_fraction_p;
                ans_q = max_fraction_q;
                high = mid;
            } else { // count < k
                // If there are fewer than 'k' fractions less than or equal to 'mid',
                // it means 'mid' is too low. We need to search in the higher range.
                low = mid;
            }
        }

        vec![ans_p, ans_q]
    }
}