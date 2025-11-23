var countNumbersWithNonDecreasingDigits = function(n) {
    if (n === 0) {
        return 1;
    }

    // This problem is equivalent to counting sequences of 'n' digits
    // d_1, d_2, ..., d_n such that 0 <= d_1 <= d_2 <= ... <= d_n <= 9.
    // This is a classic "stars and bars" problem.
    // We are choosing 'n' items (digits) from 10 types (0-9) with replacement.
    // The formula for combinations with repetition is C(m + k - 1, k),
    // where m is the number of types (10 digits) and k is the number of items to choose (n digits).
    // So, the formula is C(10 + n - 1, n) = C(n + 9, n).

    function combinations(N, K) {
        if (K < 0 || K > N) {
            return 0;
        }
        if (K === 0 || K === N) {
            return 1;
        }
        // Optimize for K > N/2 by using C(N, K) = C(N, N-K)
        if (K > N / 2) {
            K = N - K;
        }

        let res = 1;
        for (let i = 1; i <= K; ++i) {
            res = res * (N - i + 1) / i;
        }
        return res;
    }

    return combinations(n + 9, n);
};