impl Solution {
    pub fn count_vowel_strings(n: i32) -> i32 {
        // This problem can be solved using combinations with repetition, also known as "stars and bars".
        // We need to choose `n` vowels from 5 types (a, e, i, o, u) with replacement,
        // and the resulting string must be lexicographically sorted.
        // The formula for combinations with repetition is C(n + k - 1, k - 1) or C(n + k - 1, n),
        // where `n` is the number of items to choose (length of the string)
        // and `k` is the number of distinct types (number of vowels, which is 5).
        //
        // So, we need to calculate C(n + 5 - 1, 5 - 1) which simplifies to C(n + 4, 4).
        //
        // The binomial coefficient C(N, K) is calculated as N! / (K! * (N-K)!).
        // For C(n + 4, 4), this becomes:
        // ((n + 4) * (n + 3) * (n + 2) * (n + 1)) / (4 * 3 * 2 * 1)
        // which simplifies to:
        // ((n + 4) * (n + 3) * (n + 2) * (n + 1)) / 24
        //
        // Given that n is between 1 and 50, the maximum result will be for n=50:
        // C(50 + 4, 4) = C(54, 4) = (54 * 53 * 52 * 51) / 24 = 316,251.
        // This value fits comfortably within an i32. All intermediate products also fit within i32.

        ((n + 4) * (n + 3) * (n + 2) * (n + 1)) / 24
    }
}