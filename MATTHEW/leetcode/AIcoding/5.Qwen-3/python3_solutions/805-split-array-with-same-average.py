from typing import List

class Solution:
    def splitArraySameAverage(self, nums: List[int]) = bool:
        n = len(nums)
        m = n // 2
        total = sum(nums)
        dp = [set() for _ in range(m + 1)]
        dp[0].add(0)
        for num in nums:
            for i in range(m, 0, -1):
                for s in dp[i - 1]:
                    dp[i].add(s + num)
        for i in range(1, m + 1):
            if total * i % n == 0 and total * i // n in dp[i]:
                return True
        return False