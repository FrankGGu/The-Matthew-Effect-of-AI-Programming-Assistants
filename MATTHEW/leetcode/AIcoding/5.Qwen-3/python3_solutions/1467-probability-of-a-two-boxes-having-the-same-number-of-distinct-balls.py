from typing import List
import math

class Solution:
    def getProbability(self, balls: List[int]) -> float:
        total = sum(balls)
        from collections import defaultdict

        def comb(n, k):
            return math.comb(n, k)

        def dfs(i, cnt1, cnt2, count1, count2, used):
            if i == len(balls):
                if count1 == count2:
                    return used * 1.0
                else:
                    return 0.0
            res = 0.0
            for take in range(0, balls[i] + 1):
                if take > 0:
                    res += dfs(i + 1, cnt1 + 1, cnt2, count1 + take, count2, used * comb(balls[i], take))
                if balls[i] - take > 0:
                    res += dfs(i + 1, cnt1, cnt2 + 1, count1, count2 + (balls[i] - take), used * comb(balls[i], balls[i] - take))
            return res

        total_ways = 1
        for b in balls:
            total_ways *= comb(total, b)
            total -= b

        same = dfs(0, 0, 0, 0, 0, 1)
        return same / total_ways