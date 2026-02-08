class Solution {
    public int countKReducibleNumbers(int n, int k) {
        if (k <= 0) {
            // If k is non-positive, the concept of "k-reducible" (e.g., divisible by k)
            // is usually undefined or leads to infinite/ill-defined results for positive n.
            // Assuming k must be a positive integer as is typical for such problems.
            // If k=0, division by zero would occur.
            // If k is negative, the count would depend on the interpretation,
            // but for "less than N" (implicitly N > 0), it's usually not relevant.
            return 0;
        }
        if (n <= 0) {
            // No numbers less than or equal to 0 can be counted if N is non-positive.
            return 0;
        }

        // Assuming "K-Reducible" means divisible by K, and we are counting
        // numbers x such that 0 <= x < n and x % k == 0.
        // These numbers are 0, k, 2k, ..., m*k, where m*k < n.
        // The largest multiple of k that is strictly less than n is (n - 1) / k * k.
        // The number of such multiples (including 0) is ( (n - 1) / k ) + 1.
        return (n - 1) / k + 1;
    }
}