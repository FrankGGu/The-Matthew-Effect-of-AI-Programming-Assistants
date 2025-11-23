class Solution:
    def findMaximumLength(self, nums: List[int]) -> int:
        from collections import defaultdict

        n = len(nums)
        dp = [0] * n
        prev = [-1] * n
        freq = defaultdict(int)
        max_len = 0
        end_index = -1

        for i in range(n):
            freq[nums[i]] += 1
            if freq[nums[i]] == 1:
                dp[i] = 1
            else:
                dp[i] = dp[i - 1] + 1
                prev[i] = i - 1

            if dp[i] > max_len:
                max_len = dp[i]
                end_index = i

        return max_len