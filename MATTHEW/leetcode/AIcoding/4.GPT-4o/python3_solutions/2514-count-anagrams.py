class Solution:
    def countAnagrams(self, s: str) -> int:
        from collections import Counter
        from math import factorial

        def mod_inv(a, p):
            return pow(a, p - 2, p)

        def count_permutations(word):
            freq = Counter(word)
            denom = 1
            for count in freq.values():
                denom *= factorial(count)
            return factorial(len(word)) // denom

        MOD = 10**9 + 7
        words = s.split()
        result = 1

        for word in words:
            result = (result * count_permutations(word)) % MOD

        return result