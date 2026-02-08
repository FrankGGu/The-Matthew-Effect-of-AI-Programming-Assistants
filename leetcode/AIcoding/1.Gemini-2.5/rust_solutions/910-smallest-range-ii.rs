impl Solution {
    pub fn smallest_range_ii(mut a: Vec<i32>, k: i332) -> i32 {
        let n = a.len();
        if n == 1 {
            return 0;
        }

        a.sort();

        // The initial answer is the range when all elements are either increased by k or decreased by k (or no change).
        // In all these cases, the difference remains A[n-1] - A[0].
        let mut ans = a[n - 1] - a[0];

        // Iterate through all possible split points 'i'.
        // We assume elements a[0]...a[i] are increased by k,
        // and elements a[i+1]...a[n-1] are decreased by k.
        // The loop goes from i = 0 to n-2.
        for i in 0..n - 1 {
            // The minimum value in the modified array B will be the minimum of:
            // 1. The smallest element that was increased: a[0] + k
            // 2. The smallest element that was decreased: a[i+1] - k
            let min_val = std::cmp::min(a[0] + k, a[i + 1] - k);

            // The maximum value in the modified array B will be the maximum of:
            // 1. The largest element that was increased: a[i] + k
            // 2. The largest element that was decreased: a[n-1] - k
            let max_val = std::cmp::max(a[i] + k, a[n - 1] - k);

            // Update the overall minimum range found so far
            ans = std::cmp::min(ans, max_val - min_val);
        }

        ans
    }
}