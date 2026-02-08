class Solution {
    public int minOperations(int k) {
        if (k == 1) {
            return 0;
        }

        // Initialize minOperations. A baseline strategy is to only duplicate the initial '1'.
        // This requires 0 increment operations and k-1 duplicate operations, for a total of k-1 operations.
        int minOperations = k - 1;

        // Iterate through possible values for 'x'.
        // 'x' represents the value of the single element we increment to, before starting duplications.
        // We start with an array [1].
        // 1. Increment '1' to 'x': This takes (x - 1) operations.
        //    Now the array is [x].
        // 2. Duplicate 'x' until the sum is at least 'k'.
        //    If we have 'N' copies of 'x', the sum is N*x. We need N*x >= k.
        //    The minimum integer 'N' is ceil(k / x).
        //    To get 'N' copies of 'x' from one 'x', we need (N - 1) duplicate operations.
        // Total operations for a given 'x' = (x - 1) + (ceil(k / x) - 1).

        // The function x + k/x is minimized when x is close to sqrt(k).
        // Therefore, we only need to check values of x up to sqrt(k).
        // If an optimal x_opt > sqrt(k), then k/x_opt < sqrt(k).
        // The value ceil(k/x_opt) would be a candidate for x in our loop,
        // and it would likely yield a similar or better result due to the symmetry.
        for (int x = 1; x * x <= k; x++) {
            // Calculate ceil(k / x) using integer division: (k + x - 1) / x
            int numCopiesNeeded = (k + x - 1) / x;

            // Calculate total operations for this 'x'
            int currentOperations = (x - 1) + (numCopiesNeeded - 1);

            // Update the minimum operations found so far
            minOperations = Math.min(minOperations, currentOperations);
        }

        return minOperations;
    }
}