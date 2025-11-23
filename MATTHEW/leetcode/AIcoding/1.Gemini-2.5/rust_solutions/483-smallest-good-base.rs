impl Solution {
    pub fn smallest_good_base(n: String) -> String {
        let n_val = n.parse::<u64>().unwrap();

        // The case m = 1 (two '1's, e.g., 11_k) means n = k + 1.
        // So k = n - 1. This is always a valid base and gives the largest possible base.
        // We initialize our smallest_k with this value.
        let mut smallest_k = n_val - 1;

        // Iterate through possible values of m (number of '1's - 1).
        // n = 1 + k + k^2 + ... + k^m.
        // The smallest possible base k is 2.
        // So, n >= 1 + 2 + 2^2 + ... + 2^m = 2^(m+1) - 1.
        // This implies 2^(m+1) <= n + 1.
        // For n = 10^18, log2(10^18 + 1) is approximately 59.79.
        // So, m+1 can be at most 59, meaning m can be at most 58.
        // We iterate m from a safe upper bound (e.g., 60) down to 2.
        // m=1 is handled by the initial smallest_k.
        for m in (2..=60).rev() {
            // For a fixed m, we need to find k such that n = 1 + k + ... + k^m.
            // We know k^m < n, so k < n^(1/m).
            // We can use binary search to find k in the range [2, n^(1/m) + buffer].
            // The upper bound for k can be capped by our current best smallest_k - 1,
            // as we are looking for an even smaller base.
            let mut low = 2;
            let mut high = (n_val as f64).powf(1.0 / m as f64) as u64 + 2; // Add a small buffer for float precision
            high = high.min(smallest_k - 1); // Cap high at current best k - 1

            // If the calculated high bound is less than low, no k is possible for this m.
            if high < low {
                continue;
            }

            while low <= high {
                let mid_k = low + (high - low) / 2;

                // Calculate sum = 1 + mid_k + mid_k^2 + ... + mid_k^m
                let mut current_sum = 0;
                let mut current_power = 1; // Represents mid_k^0
                let mut overflow = false;

                for _ in 0..=m {
                    // Check for overflow before adding current_power to current_sum
                    // If n_val - current_sum < current_power, then current_sum + current_power > n_val
                    if n_val - current_sum < current_power {
                        overflow = true;
                        break;
                    }
                    current_sum += current_power;

                    // If it's not the last term (i.e., not mid_k^m), prepare for the next power
                    if _ < m {
                        // Check for overflow before multiplying current_power by mid_k
                        // If n_val / mid_k < current_power, then current_power * mid_k > n_val
                        if mid_k == 0 || n_val / mid_k < current_power { // mid_k cannot be 0 as low starts at 2
                            overflow = true;
                            break;
                        }
                        current_power *= mid_k;
                    }
                }

                if overflow || current_sum > n_val {
                    // mid_k is too large, try a smaller base
                    high = mid_k - 1;
                } else if current_sum < n_val {
                    // mid_k is too small, try a larger base
                    low = mid_k + 1;
                } else { // current_sum == n_val
                    // Found a good base mid_k for this m.
                    // Since we iterate m downwards, the first k we find will be the smallest overall.
                    smallest_k = mid_k;
                    break; // Break from binary search and move to the next smaller m
                }
            }
        }

        smallest_k.to_string()
    }
}