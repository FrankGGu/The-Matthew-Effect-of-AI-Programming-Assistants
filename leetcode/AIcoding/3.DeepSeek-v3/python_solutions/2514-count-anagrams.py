import math
from collections import defaultdict

class Solution:
    def countAnagrams(self, s: str) -> int:
        MOD = 10**9 + 7
        words = s.split()
        res = 1
        for word in words:
            freq = defaultdict(int)
            for c in word:
                freq[c] += 1
            total = math.factorial(len(word))
            for count in freq.values():
                total = total * pow(math.factorial(count), MOD - 2, MOD) % MOD
            res = res * total % MOD
        return res