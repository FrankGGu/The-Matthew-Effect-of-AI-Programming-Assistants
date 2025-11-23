class Solution:
    def numberOfWays(self, points: List[int]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        for p in points:
            count[p] += 1

        ways = 0
        for k in count:
            ways += count[k] * (count[k] - 1) // 2

        return ways