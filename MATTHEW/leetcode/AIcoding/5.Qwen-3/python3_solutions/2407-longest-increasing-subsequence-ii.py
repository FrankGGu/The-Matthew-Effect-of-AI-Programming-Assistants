class Solution:
    def lengthOfLIS(self, nums: List[int], k: int) -> int:
        import bisect

        dp = []
        for num in nums:
            idx = bisect.bisect_left(dp, num)
            if idx == len(dp):
                dp.append(num)
            else:
                dp[idx] = num
        return len(dp)