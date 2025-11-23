class Solution:
    def isValidPartition(self, nums: list[int]) -> bool:
        n = len(nums)

        dp = [False] * (n + 1)
        dp[0] = True

        for i in range(1, n + 1):
            # Check for a 2-element partition ending at nums[i-1]
            # This involves nums[i-2] and nums[i-1]
            if i >= 2 and dp[i-2]:
                if nums[i-2] == nums[i-1]:
                    dp[i] = True

            # Check for a 3-element partition ending at nums[i-1]
            # This involves nums[i-3], nums[i-2], nums[i-1]
            if i >= 3 and dp[i-3]:
                # Case 1: Three equal elements
                if nums[i-3] == nums[i-2] and nums[i-2] == nums[i-1]:
                    dp[i] = True

                # Case 2: Three consecutive increasing elements
                if nums[i-3] + 1 == nums[i-2] and nums[i-2] + 1 == nums[i-1]:
                    dp[i] = True

        return dp[n]