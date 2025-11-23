class Solution:
    def maxScore(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = {}

        def solve(i, k):
            if (i, k) in dp:
                return dp[(i, k)]

            if i == n - 1:
                return nums[i]

            if k == 0:
                return float('-inf')

            score = float('-inf')
            for j in range(1, k + 1):
                if i + j < n:
                    score = max(score, nums[i] + solve(i + j, k - 1))

            dp[(i, k)] = score
            return score

        return solve(0, k)