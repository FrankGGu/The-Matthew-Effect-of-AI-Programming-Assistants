class Solution:
    def rob(self, nums: list[int]) -> int:
        n = len(nums)

        if n == 0:
            return 0
        if n == 1:
            return nums[0]

        # Helper function for the linear House Robber problem
        def rob_linear(arr: list[int]) -> int:
            if not arr:
                return 0
            if len(arr) == 1:
                return arr[0]

            # dp[i] = max money up to house i
            # We use two variables to optimize space:
            # prev2 stores dp[i-2]
            # prev1 stores dp[i-1]
            prev2 = 0
            prev1 = 0

            for num in arr:
                current_max = max(prev1, prev2 + num)
                prev2 = prev1
                prev1 = current_max
            return prev1

        # Case 1: Rob houses from index 0 to n-2 (excluding the last house)
        # This allows robbing the first house.
        max_money_excluding_last = rob_linear(nums[0 : n - 1])

        # Case 2: Rob houses from index 1 to n-1 (excluding the first house)
        # This allows robbing the last house.
        max_money_excluding_first = rob_linear(nums[1 : n])

        # The maximum amount of money is the maximum of these two cases.
        return max(max_money_excluding_last, max_money_excluding_first)