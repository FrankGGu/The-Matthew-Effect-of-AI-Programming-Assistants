class Solution {
    public long distributeCandies(int n, int limit) {
        // This problem is a classic stars and bars problem with an upper limit constraint.
        // We need to find the number of non-negative integer solutions to x1 + x2 + x3 = n
        // such that 0 <= x_i <= limit for i = 1, 2, 3.
        // We use the Principle of Inclusion-Exclusion.

        // Let N be the total number of solutions without any upper limit constraint.
        // For k variables summing to n, C(n + k - 1, k - 1). Here k=3.
        // N = C(n + 3 - 1, 3 - 1) = C(n + 2, 2)

        // Let A_i be the property that x_i > limit (i.e., x_i >= limit + 1).
        // We want to find N(A_1' A_2' A_3') = N - S1 + S2 - S3.

        // S1 = sum(N(A_i)) = C(3, 1) * N(A_1)
        // To find N(A_1): let x1' = x1 - (limit + 1).
        // Then (x1' + limit + 1) + x2 + x3 = n
        // x1' + x2 + x3 = n - (limit + 1)
        // Number of solutions is C(n - (limit + 1) + 2, 2).
        // If n - (limit + 1) < 0, this term is 0.

        // S2 = sum(N(A_i A_j)) = C(3, 2) * N(A_1 A_2)
        // To find N(A_1 A_2): let x1' = x1 - (limit + 1), x2' = x2 - (limit + 1).
        // Then (x1' + limit + 1) + (x2' + limit + 1) + x3 = n
        // x1' + x2' + x3 = n - 2 * (limit + 1)
        // Number of solutions is C(n - 2 * (limit + 1) + 2, 2).
        // If n - 2 * (limit + 1) < 0, this term is 0.

        // S3 = N(A_1 A_2 A_3) = C(3, 3) * N(A_1 A_2 A_3)
        // To find N(A_1 A_2 A_3): let x1' = x1 - (limit + 1), x2' = x2 - (limit + 1), x3' = x3 - (limit + 1).
        // Then (x1' + limit + 1) + (x2' + limit + 1) + (x3' + limit + 1) = n
        // x1' + x2' + x3' = n - 3 * (limit + 1)
        // Number of solutions is C(n - 3 * (limit + 1) + 2, 2).
        // If n - 3 * (limit + 1) < 0, this term is 0.

        long totalWays = combinations(n + 2);

        long waysExceedOneChild = 0;
        long remainingCandies1 = (long)n - (limit + 1);
        if (remainingCandies1 >= 0) {
            waysExceedOneChild = 3 * combinations(remainingCandies1 + 2);
        }

        long waysExceedTwoChildren = 0;
        long remainingCandies2 = (long)n - 2L * (limit + 1);
        if (remainingCandies2 >= 0) {
            waysExceedTwoChildren = 3 * combinations(remainingCandies2 + 2);
        }

        long waysExceedThreeChildren = 0;
        long remainingCandies3 = (long)n - 3L * (limit + 1);
        if (remainingCandies3 >= 0) {
            waysExceedThreeChildren = 1 * combinations(remainingCandies3 + 2);
        }

        return totalWays - waysExceedOneChild + waysExceedTwoChildren - waysExceedThreeChildren;
    }

    // Helper function to calculate C(k, 2)
    // C(k, 2) = k * (k - 1) / 2
    // If k < 2, C(k, 2) = 0.
    private long combinations(long k) {
        if (k < 2) {
            return 0;
        }
        return k * (k - 1) / 2;
    }
}