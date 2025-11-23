class Solution {
public:
    int consecutiveNumbersSum(int n) {
        int count = 0;
        // The sum of k consecutive positive integers starting from x is:
        // n = x + (x+1) + ... + (x+k-1)
        // This is an arithmetic series sum:
        // n = k*x + k*(k-1)/2
        // Multiply by 2 to clear the fraction:
        // 2n = 2kx + k(k-1)
        // Factor out k:
        // 2n = k * (2x + k - 1)

        // Let A = k (the number of terms)
        // Let B = 2x + k - 1
        // So, 2n = A * B

        // We know x must be a positive integer, so x >= 1.
        // From B = 2x + k - 1:
        // Since x >= 1, 2x >= 2.
        // So, B >= 2 + k - 1 = k + 1.
        // This implies B > A (since A = k and k >= 1).

        // Also, consider the difference B - A:
        // B - A = (2x + k - 1) - k = 2x - 1.
        // Since x >= 1, 2x - 1 is always an odd positive integer.
        // This means B - A must be odd.
        // If B - A is odd, then A and B must have different parities (one is even, one is odd).

        // So, we are looking for pairs of factors (A, B) of 2n such that:
        // 1. A * B = 2n
        // 2. A < B (which implies B >= A+1)
        // 3. A and B have different parities.

        // If we find such a pair (A, B), we can set k = A.
        // Then we can find x:
        // B = 2x + k - 1
        // 2x = B - k + 1
        // x = (B - k + 1) / 2
        // Since B - k is odd, B - k + 1 is even, so x will be an integer.
        // Since B >= k + 1, B - k + 1 >= 2, so x >= 1.
        // Thus, every such pair (A, B) corresponds to a unique valid solution.

        // We iterate through possible values for A (which is k, the number of terms).
        // The condition B >= A+1 implies A * (A+1) <= A * B = 2n.
        // So, A * (A+1) <= 2n gives an upper bound for A.

        long long two_n = 2LL * n; // Use long long for 2n to prevent potential overflow
                                   // if n is large and intermediate products exceed INT_MAX.

        for (long long k = 1; k * (k + 1) <= two_n; ++k) {
            // k represents A in our derivation.
            // Check if k is a divisor of 2n.
            if (two_n % k == 0) {
                long long M = two_n / k; // M represents B in our derivation.

                // Check condition 2: A < B (k < M)
                // This is implicitly handled by k*(k+1) <= two_n, which means M >= k+1.
                // So k < M is always true if k*(k+1) <= two_n and M = two_n/k.

                // Check condition 3: A and B have different parities.
                if ((k % 2) != (M % 2)) {
                    count++;
                }
            }
        }

        return count;
    }
};