import math

class Solution:
    def numberOfSequence(self, n: int, sick: List[int]) -> int:
        sick.sort()
        res = 1
        mod = 10**9 + 7
        total_gaps = 0
        fact = [1] * (n + 1)
        for i in range(1, n + 1):
            fact[i] = fact[i - 1] * i % mod

        inv_fact = [1] * (n + 1)
        inv_fact[n] = pow(fact[n], mod - 2, mod)
        for i in range(n - 1, -1, -1):
            inv_fact[i] = inv_fact[i + 1] * (i + 1) % mod

        m = len(sick)
        for i in range(1, m):
            gap = sick[i] - sick[i - 1] - 1
            if gap > 0:
                total_gaps += gap
                res = res * pow(2, gap - 1, mod) % mod
                res = res * inv_fact[gap] % mod

        left_gap = sick[0]
        if left_gap > 0:
            total_gaps += left_gap
            res = res * inv_fact[left_gap] % mod

        right_gap = n - 1 - sick[-1]
        if right_gap > 0:
            total_gaps += right_gap
            res = res * inv_fact[right_gap] % mod

        res = res * fact[total_gaps] % mod
        return res