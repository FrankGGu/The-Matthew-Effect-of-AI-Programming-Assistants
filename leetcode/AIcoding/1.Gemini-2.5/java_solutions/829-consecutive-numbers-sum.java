class Solution {
    public int consecutiveNumbersSum(int n) {
        // The problem can be rephrased:
        // N = x + (x+1) + ... + (x+k-1)
        // N = k*x + k*(k-1)/2
        // 2N = 2kx + k(k-1)
        // 2N = k * (2x + k - 1)

        // Let A = k and B = 2x + k - 1.
        // So, 2N = A * B.
        // We also know that A >= 1 (number of terms) and x >= 1 (starting number).
        // From x >= 1, we have 2x >= 2, so 2x - 1 >= 1.
        // B - A = (2x + k - 1) - k = 2x - 1.
        // Since 2x - 1 is always an odd positive integer, A and B must have different parities.
        // Also, B - A = 2x - 1 >= 1, which implies B > A.

        // So, we need to find the number of pairs of factors (A, B) of 2N such that:
        // 1. A * B = 2N
        // 2. A < B
        // 3. A and B have different parities (one is odd, one is even).

        // Let's analyze the parity condition:
        // If A is odd, then B must be even.
        // If A is even, then B must be odd.

        // Consider the prime factorization of N: N = 2^p * M, where M is an odd number.
        // Then 2N = 2^(p+1) * M.

        // Case 1: A is odd.
        // If A is an odd factor of 2N, then A must be an odd factor of M.
        // In this case, B = 2N / A = (2^(p+1) * M) / A. Since A is an odd factor of M, M/A is an odd integer.
        // So B = 2^(p+1) * (M/A), which is always an even number (since p+1 >= 1).
        // Thus, if A is an odd factor of M, the parity condition (A odd, B even) is always satisfied.

        // Case 2: A is even.
        // If A is an even factor of 2N, then B = 2N / A must be odd.
        // For B to be odd, A must contain all factors of 2 from 2N.
        // So A must be of the form 2^(p+1) * m', where m' is an odd factor of M.
        // In this case, B = (2^(p+1) * M) / (2^(p+1) * m') = M / m', which is always an odd number.
        // Thus, if A is of the form 2^(p+1) * m', the parity condition (A even, B odd) is always satisfied.

        // Combining these, the valid values for A (which is k, the number of terms) are:
        // 1. Any odd factor of M (the odd part of N).
        // 2. Any factor of the form 2^(p+1) * m', where m' is an odd factor of M.

        // Now, let's consider the condition B > A.
        // This means 2N/A > A, or 2N > A^2.
        // This is equivalent to x >= 1.

        // It turns out that any odd factor 'd' of N contributes exactly one way to form N.
        // If 'd' is an odd factor of N, then 'd' is an odd factor of M.
        // If we take k = d (Case 1), we get x = N/d - (d-1)/2. This x is an integer.
        // We need x >= 1, which means d(d+1) <= 2N.
        // If we take k = 2N/d (Case 2, where d is an odd factor of N, so 2N/d is even and contains all powers of 2 from 2N),
        // we get x = (d - (2N/d) + 1)/2. This x is an integer.
        // We need x >= 1, which means (2N/d)(2N/d + 1) <= 2N, or d > sqrt(2N).

        // It can be shown that for any odd factor 'd' of N, exactly one of these two conditions holds:
        // 1. d(d+1) <= 2N (meaning k=d is a valid number of terms)
        // 2. d > sqrt(2N) (meaning k=2N/d is a valid number of terms)
        // And importantly, d can never be equal to sqrt(2N) if d is an odd factor of N.
        // (If d = sqrt(2N), then 2N = d^2. Since d is odd, d^2 is odd. But 2N is even. Contradiction.)

        // Therefore, every odd factor of N corresponds to exactly one way to express N as a sum of consecutive integers.
        // So the problem reduces to finding the number of odd divisors of N.

        // Step 1: Remove all factors of 2 from n to get its odd part (M).
        while (n % 2 == 0) {
            n /= 2;
        }

        // Step 2: Count the number of divisors of this odd part (M, now stored in n).
        int count = 0;
        for (int i = 1; i * i <= n; i++) {
            if (n % i == 0) {
                // If i is a divisor, then n/i is also a divisor.
                // If i*i == n, then i and n/i are the same divisor (e.g., for n=9, i=3).
                // In this case, we count it once.
                if (i * i == n) {
                    count++;
                } else {
                    // Otherwise, i and n/i are two distinct divisors (e.g., for n=15, i=3, n/i=5).
                    // We count both.
                    count += 2;
                }
            }
        }
        return count;
    }
}