class Solution:
    def maximumScore(self, nums: list[int], multipliers: list[int]) -> int:
        n = len(nums)
        m = len(multipliers)

        # dp[j] will store the maximum score after 'i' operations,
        # having taken 'j' elements from the left side of nums.
        # The number of elements taken from the right side will be (i - j).
        # We need m+1 size for dp array because j can go from 0 to m.
        dp = [0] * (m + 1) 

        # Iterate through each multiplier (i represents the current operation count, from 1 to m)
        for i in range(1, m + 1):
            # new_dp will store the scores for 'i' operations
            new_dp = [-float('inf')] * (m + 1)
            current_multiplier = multipliers[i - 1]

            # Iterate through possible number of elements taken from the left (j)
            # j can range from 0 (all from right) to i (all from left)
            for j in range(i + 1):
                score_from_left = -float('inf')
                # If we take nums[j-1] (the j-th element from the left) in this step:
                # This is possible only if j > 0 and the previous state (i-1 operations, j-1 from left) was valid.
                if j > 0 and dp[j - 1] != -float('inf'):
                    score_from_left = dp[j - 1] + current_multiplier * nums[j - 1]

                score_from_right = -float('inf')
                # If we take nums[n - (i - j)] (the (i-j)-th element from the right) in this step:
                # This is possible only if j < i (meaning i-j > 0, so we actually took from right)
                # and the previous state (i-1 operations, j from left) was valid.
                if j < i and dp[j] != -float('inf'):
                    # The index of the element taken from the right.
                    # If (i-j) elements have been taken from the right,
                    # these are nums[n-1], nums[n-2], ..., nums[n-(i-j)].
                    # So the current one taken is nums[n-(i-j)].
                    right_idx = n - (i - j)
                    score_from_right = dp[j] + current_multiplier * nums[right_idx]

                new_dp[j] = max(score_from_left, score_from_right)

            dp = new_dp

        # The maximum score will be the maximum value in the final dp array,
        # which represents m operations completed.
        return max(dp)