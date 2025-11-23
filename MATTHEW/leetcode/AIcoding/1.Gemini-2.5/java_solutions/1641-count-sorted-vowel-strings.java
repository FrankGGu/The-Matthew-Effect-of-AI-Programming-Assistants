class Solution {
    public int countVowelStrings(int n) {
        // This problem is equivalent to finding the number of combinations with repetition.
        // We need to choose 'n' vowels from 5 types (a, e, i, o, u) such that they are sorted.
        // This can be modeled using stars and bars.
        // The formula for combinations with repetition is C(n + k - 1, k - 1) or C(n + k - 1, n),
        // where 'n' is the number of items to choose (length of the string),
        // and 'k' is the number of distinct types of items (number of vowels, which is 5).

        // So, we need to calculate C(n + 5 - 1, 5 - 1) = C(n + 4, 4).

        // C(N, K) = N * (N-1) * ... * (N-K+1) / K!
        // For C(n + 4, 4):
        // N = n + 4
        // K = 4

        long numerator = (long)(n + 4) * (n + 3) * (n + 2) * (n + 1);
        long denominator = 4 * 3 * 2 * 1; // 4! = 24

        return (int)(numerator / denominator);
    }
}