class Solution:
    def countVowelStrings(self, n: int) -> int:
        # This problem can be solved using combinations (stars and bars).
        # We are effectively choosing n vowels from 5 types ('a', 'e', 'i', 'o', 'u')
        # with replacement, and the order is fixed (lexicographically sorted).
        # This is a classic stars and bars problem: C(n + k - 1, k - 1),
        # where n is the number of items to choose (length of string)
        # and k is the number of categories (number of distinct vowels, which is 5).
        #
        # So, the formula becomes C(n + 5 - 1, 5 - 1) which simplifies to C(n + 4, 4).
        #
        # C(N, K) = N! / (K! * (N-K)!)
        # C(n + 4, 4) = (n + 4) * (n + 3) * (n + 2) * (n + 1) / (4 * 3 * 2 * 1)

        # The denominator 4 * 3 * 2 * 1 is 24.
        numerator = (n + 4) * (n + 3) * (n + 2) * (n + 1)
        denominator = 24

        return numerator // denominator