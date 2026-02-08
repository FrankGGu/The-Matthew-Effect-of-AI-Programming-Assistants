class Solution {
    public int minimumOperations(int n, int p) {
        // We are looking for the minimum number of operations, k.
        // In each operation, we subtract (x - p) from n.
        // After k operations, n_new = n_initial - sum(x_i - p) for i=1 to k.
        // We want n_new = 0.
        // This means n_initial - sum(x_i) + k * p = 0.
        // Rearranging, we get: n_initial + k * p = sum(x_i).
        // Let target_sum = n_initial + k * p.
        // We need to find the minimum k such that target_sum can be written as the sum of k positive integers x_i.
        // The conditions for this are:
        // 1. target_sum >= k: Since each x_i must be a positive integer (x_i >= 1), their sum must be at least k.
        // 2. Long.bitCount(target_sum) <= k: This is a known property in number theory. An integer Y can be written as the sum of k positive integers if and only if Y >= k and the number of set bits in Y's binary representation (popcount) is less than or equal to k. The popcount condition ensures that Y can be represented as a sum of k powers of 2 (by splitting powers of 2 if k is larger than the actual bit count).

        // We iterate k (number of operations) starting from 1.
        // The maximum value for Long.bitCount(X) for a positive long X is 63 (for Long.MAX_VALUE).
        // If k is greater than 63, then Long.bitCount(target_sum) <= k will always be true (assuming target_sum > 0).
        // This implies that if a solution exists, the minimum k must be relatively small.
        // For p >= 1, n + k*p >= k is always true for n >= 1, k >= 1. So the minimum k will be found when Long.bitCount(n + k*p) <= k, which implies k <= 63.
        // For p <= 0, n + k*p >= k implies k <= n / (1-p). But we still need Long.bitCount(n + k*p) <= k, which means k must be at least Long.bitCount(...), so k is also small.
        // Therefore, checking k up to a small constant (e.g., 65) is sufficient.

        for (int k = 1; k <= 65; k++) { // k represents the number of operations
            long targetSum = (long) n + (long) k * p;

            // Condition 1: target_sum must be at least k (sum of k positive integers)
            // If target_sum is negative, it cannot be a sum of positive integers, so target_sum >= k will be false.
            if (targetSum >= k) {
                // Condition 2: Check if target_sum can be represented as sum of k positive integers
                // This is true if Long.bitCount(target_sum) <= k
                if (Long.bitCount(targetSum) <= k) {
                    return k;
                }
            }
        }

        // If no k is found within the reasonable range, it's impossible to make n zero.
        return -1;
    }
}