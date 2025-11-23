class Solution:
    def longestArithSeqLength(self, nums: List[int]) -> int:
        n = len(nums)
        dp = {}
        max_len = 0
        for i in range(n):
            for j in range(i):
                diff = nums[i] - nums[j]
                if (j, diff) in dp:
                    dp[(i, diff)] = dp[(j, diff)] + 1
                else:
                    dp[(i, diff)] = 2
                max_len = max(max_len, dp[(i, diff)])
        return max_len