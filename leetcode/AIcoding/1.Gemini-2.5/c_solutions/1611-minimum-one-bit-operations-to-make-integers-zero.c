int minimumOneBitOperations(int n) {
    int ans = 0;
    int sign = 1; // Alternates between 1 and -1, representing the recursive formula's subtraction

    while (n > 0) {
        int k = 0;
        // Find the position of the most significant bit (MSB) of n.
        // k is such that 2^k <= n < 2^(k+1).
        // For example, if n=4 (binary 100), k=2 because 2^2 <= 4 < 2^3.
        // If n=1 (binary 001), k=0 because 2^0 <= 1 < 2^1.
        while ((1 << (k + 1)) <= n) {
            k++;
        }

        // The term (2^(k+1) - 1) is derived from the recursive relation.
        // It represents the cost to make 2^k zero, plus the cost to make 2^k-1 zero, effectively.
        // It's also the maximum value for numbers up to 2^(k+1)-1 in this sequence.
        int term = (1 << (k + 1)) - 1;

        // Apply the recursive formula: f(n) = (2^(k+1) - 1) - f(n - 2^k)
        // The 'ans' variable accumulates these terms with alternating signs.
        ans += sign * term;

        // Flip the sign for the next iteration, reflecting the subtraction in the formula.
        sign = -sign;

        // Remove the MSB from n. This is equivalent to n - 2^k when 2^k is the MSB of n.
        // This prepares n for the next "recursive call" in the iteration.
        n = n ^ (1 << k);
    }

    return ans;
}