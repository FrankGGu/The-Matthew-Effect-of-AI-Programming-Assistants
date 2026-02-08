class Solution:
    def maxSumOfThreeSubarrays(self, nums: List[int], k: int) -> List[int]:
        n = len(nums)
        prefix_sum = [0] * (n + 1)

        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        dp = [[0] * (n + 1) for _ in range(4)]
        index = [[0] * (n + 1) for _ in range(4)]

        for i in range(1, 4):
            for j in range(k * i, n + 1):
                current_sum = prefix_sum[j] - prefix_sum[j - k]
                if dp[i][j - k] + current_sum > dp[i][j]:
                    dp[i][j] = dp[i][j - k] + current_sum
                    index[i][j] = j - k

        max_sum = 0
        answer = []
        for j in range(n + 1):
            if dp[3][j] > max_sum:
                max_sum = dp[3][j]
                answer = [index[3][j], index[2][index[3][j]], index[1][index[2][index[3][j]]]]

        return answer