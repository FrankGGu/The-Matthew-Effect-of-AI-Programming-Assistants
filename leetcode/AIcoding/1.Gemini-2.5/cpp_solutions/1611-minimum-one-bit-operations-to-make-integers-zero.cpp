class Solution {
public:
    int minimumOneBitOperations(int n) {
        int ans = 0;
        int sign = 1; // Represents the alternating sign in the recurrence relation

        // Iterate from the most significant possible bit (e.g., 30 for 32-bit int
        // as n <= 10^9 < 2^30) down to the least significant bit (0).
        for (int k = 30; k >= 0; --k) {
            // Check if the k-th bit of n is set.
            // If it is set, this bit contributes to the total operations.
            if ((n >> k) & 1) {
                // The recurrence relation for f(n) is f(n) = (2^(k+1) - 1) - f(n - 2^k),
                // where k is the position of the most significant bit of n.
                // This iterative approach effectively unrolls this recursion.
                // Each time a set bit is encountered, we add/subtract a term (2^(k+1) - 1).
                // The 'sign' variable handles the alternating addition and subtraction.
                ans += sign * ((1 << (k + 1)) - 1);

                // Flip the sign for the next term in the effective recurrence.
                // This is because f(n - 2^k) is subtracted in the recurrence.
                sign *= -1;
            }
        }

        return ans;
    }
};