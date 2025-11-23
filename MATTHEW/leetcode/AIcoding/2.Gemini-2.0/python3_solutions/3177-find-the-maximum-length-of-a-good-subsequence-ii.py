class Solution:
    def findMaximumLength(self, nums: list[int]) -> int:
        n = len(nums)
        nums.sort()
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        dp = {}

        def solve(idx):
            if idx == n:
                return 0

            if idx in dp:
                return dp[idx]

            ans = solve(idx + 1)

            l, r = idx + 1, n - 1
            next_idx = -1
            while l <= r:
                mid = (l + r) // 2
                if prefix_sum[idx + 1] >= nums[mid]:
                    next_idx = mid
                    l = mid + 1
                else:
                    r = mid - 1

            if next_idx != -1:
                ans = max(ans, 1 + solve(next_idx + 1))

            dp[idx] = ans
            return ans

        return solve(0)