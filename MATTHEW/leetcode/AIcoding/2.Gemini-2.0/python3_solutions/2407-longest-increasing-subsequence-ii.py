class Solution:
    def lengthOfLIS(self, nums: List[int], k: int) -> int:
        import bisect
        dp = []
        for num in nums:
            idx = bisect.bisect_right(dp, (num - k - 1, float('inf')))
            idx2 = bisect.bisect_right(dp, (num - 1, float('inf')))
            val = 1
            if idx > 0:
                val = dp[idx - 1][1] + 1

            idx3 = bisect.bisect_right(dp, (num, float('inf')))
            if idx3 > 0 and dp[idx3-1][1] >= val:
                continue

            while len(dp) > 0 and dp[-1][1] <= val:
                dp.pop()

            dp.append((num, val))

        return dp[-1][1]