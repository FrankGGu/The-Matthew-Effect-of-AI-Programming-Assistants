class Solution:
    def findTargetSumWays(self, nums: List[int], target: int) -> int:
        from collections import defaultdict

        memo = defaultdict(int)
        memo[0] = 1

        for num in nums:
            next_memo = defaultdict(int)
            for key in memo:
                next_memo[key + num] += memo[key]
                next_memo[key - num] += memo[key]
            memo = next_memo

        return memo[target]