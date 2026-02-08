class Solution:
    def findNumberOfLIS(self, nums: list[int]) -> int:
        n = len(nums)
        if n == 0:
            return 0

        dp = [(1, 1)] * n  # dp[i] = (length, count) of LIS ending at nums[i]

        for i in range(n):
            for j in range(i):
                if nums[i] > nums[j]:
                    prev_len, prev_count = dp[j]
                    curr_len, curr_count = dp[i]

                    if prev_len + 1 > curr_len:
                        dp[i] = (prev_len + 1, prev_count)
                    elif prev_len + 1 == curr_len:
                        dp[i] = (curr_len, curr_count + prev_count)

        max_len = 0
        for length, _ in dp:
            max_len = max(max_len, length)

        ans = 0
        for length, count in dp:
            if length == max_len:
                ans += count

        return ans