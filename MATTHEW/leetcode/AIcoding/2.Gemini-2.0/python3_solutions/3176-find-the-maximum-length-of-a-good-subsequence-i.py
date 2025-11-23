class Solution:
    def findMaximumLength(self, nums: list[int]) -> int:
        n = len(nums)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        dp = {}
        dp[0] = 0
        last = {0: 0}

        for i in range(1, n + 1):
            dp[i] = dp[i - 1]

            left = 0
            right = i - 1
            ans = -1
            while left <= right:
                mid = (left + right) // 2
                if prefix_sum[i] - prefix_sum[mid] >= prefix_sum[mid]:
                    ans = mid
                    left = mid + 1
                else:
                    right = mid - 1

            if ans != -1:
                dp[i] = max(dp[i], dp.get(ans, -1) + 1)

            if prefix_sum[i] not in last or dp[i] > dp.get(last[prefix_sum[i]], -1):
                last[prefix_sum[i]] = i

        return dp[n]