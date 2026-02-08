class Solution:
    def minimumPairRemoval(self, nums: list[int]) -> int:
        n = len(nums)
        dp = {}

        def solve(i, j):
            if i >= j:
                return 0
            if (i, j) in dp:
                return dp[(i, j)]

            ans = 1 + solve(i + 1, j)
            for k in range(i + 1, j + 1):
                if nums[i] + nums[k] <= nums[k + 1] if k < j else nums[i] + nums[k] <= float('inf'):
                    ans = min(ans, 1 + solve(i + 1, k - 1) + solve(k + 1, j))

            dp[(i, j)] = ans
            return ans

        return solve(0, n - 1)