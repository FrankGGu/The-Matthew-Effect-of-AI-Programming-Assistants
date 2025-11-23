from math import comb
from collections import Counter

class Solution:
    def getProbability(self, balls: List[int]) -> float:
        total = sum(balls)
        n = total // 2
        k = len(balls)

        def dfs(pos, count1, count2, distinct1, distinct2, current_prob):
            if pos == k:
                if count1 == n and count2 == n and distinct1 == distinct2:
                    return current_prob
                else:
                    return 0.0

            res = 0.0
            for i in range(0, balls[pos] + 1):
                new_count1 = count1 + i
                new_count2 = count2 + (balls[pos] - i)
                if new_count1 > n or new_count2 > n:
                    continue
                new_distinct1 = distinct1 + (1 if i > 0 else 0)
                new_distinct2 = distinct2 + (1 if (balls[pos] - i) > 0 else 0)
                ways = comb(balls[pos], i)
                res += dfs(pos + 1, new_count1, new_count2, new_distinct1, new_distinct2, current_prob * ways)
            return res

        total_ways = dfs(0, 0, 0, 0, 0, 1.0)
        valid_ways = total_ways
        all_possible = comb(total, n)

        return valid_ways / all_possible