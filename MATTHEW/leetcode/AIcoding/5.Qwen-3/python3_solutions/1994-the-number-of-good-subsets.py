from collections import Counter
from typing import List

class Solution:
    def numberOfGoodSubsets(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        prime_factors = {
            2: {2},
            3: {3},
            5: {5},
            7: {7},
            11: {11},
            13: {13},
            17: {17},
            19: {19},
            23: {23},
            29: {29},
            31: {31}
        }

        count = Counter(nums)
        res = 0
        dp = [1] * (1 << 11)

        for num in count:
            if num == 1:
                continue
            factors = set()
            for p in prime_factors:
                if num % p == 0:
                    factors.add(p)
            if len(factors) == 0:
                continue
            mask = 0
            for p in factors:
                mask |= 1 << (p - 2)
            for i in range(1 << 11):
                if (i & mask) == 0:
                    dp[i | mask] = (dp[i | mask] + dp[i] * count[num]) % MOD

        for i in range(1, 1 << 11):
            res = (res + dp[i]) % MOD

        return res