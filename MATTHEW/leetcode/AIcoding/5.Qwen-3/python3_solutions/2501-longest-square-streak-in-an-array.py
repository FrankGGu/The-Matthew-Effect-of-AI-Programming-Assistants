class Solution:
    def longestSquareStreak(self, nums: List[int]) -> int:
        nums = list(set(nums))
        nums.sort()
        dp = {}
        max_len = 0
        for num in nums:
            if num in dp:
                continue
            current = num
            length = 1
            while current * current in nums:
                current *= current
                length += 1
            dp[num] = length
            max_len = max(max_len, length)
        return max_len if max_len >= 2 else -1