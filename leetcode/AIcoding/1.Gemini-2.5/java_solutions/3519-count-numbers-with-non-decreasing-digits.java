class Solution {
    public int countNumbers(int n) {
        if (n == 0) {
            return 0;
        }

        int totalCount = 0;
        // Iterate for numbers with k digits, from 1 to n
        for (int k = 1; k <= n; k++) {
            // We are counting k-digit numbers d1 d2 ... dk such that 1 <= d1 <= d2 <= ... <= dk <= 9.
            // This is a classic combinatorics problem: choosing k items from 9 distinct items (digits 1-9)
            // with replacement, where the order of selection doesn't matter (as they are sorted into non-decreasing order).
            // Using the stars and bars formula for combinations with repetition: C(n + k - 1, k)
            // Here, 'n' in the formula is the number of distinct items to choose from (9 digits: 1 through 9).
            // 'k' in the formula is the number of items to choose (k digits for the number).
            // So, the formula becomes C(9 + k - 1, k) = C(k + 8, k).
            // Using the identity C(N, K) = C(N, N-K), we can simplify this to C(k + 8, (k + 8) - k) = C(k + 8, 8).
            totalCount += combinations(k + 8, 8);
        }
        return totalCount;
    }

    // Helper function to calculate combinations C(N, K)
    // This function calculates N choose K, which is N! / (K! * (N-K)!)
    private long combinations(int N, int K) {
        if (K < 0 || K > N) {
            return 0;
        }
        if (K == 0 || K == N) {
            return 1;
        }
        // Optimization: C(N, K) = C(N, N-K). Choose the smaller K to reduce calculations.
        if (K > N / 2) {
            K = N - K;
        }

        long res = 1;
        for (int i = 1; i <= K; i++) {
            res = res * (N - i + 1) / i;
        }
        return res;
    }
}