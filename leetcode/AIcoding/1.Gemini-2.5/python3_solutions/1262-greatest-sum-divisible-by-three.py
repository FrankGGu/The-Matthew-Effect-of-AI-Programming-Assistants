import math

class Solution:
    def maxSumDivThree(self, nums: list[int]) -> int:
        # dp[i] stores the maximum sum encountered so far that has a remainder i when divided by 3.
        # dp[0]: max sum % 3 == 0
        # dp[1]: max sum % 3 == 1
        # dp[2]: max sum % 3 == 2
        # Initialize with 0 for remainder 0, and negative infinity for remainders 1 and 2
        # to ensure any valid sum will be greater.
        dp = [0, -math.inf, -math.inf]

        for num in nums:
            # Create a temporary array to store the new dp values for the current number.
            # This is crucial to avoid using updated values from the current iteration
            # when calculating other dp states.
            temp_dp = list(dp)

            for i in range(3):
                # Only consider valid previous sums (not -math.inf)
                if dp[i] != -math.inf:
                    current_sum = dp[i] + num
                    remainder = current_sum % 3
                    # Update the maximum sum for the calculated remainder
                    temp_dp[remainder] = max(temp_dp[remainder], current_sum)

            # Update the main dp array with the new sums calculated for the current number
            dp = temp_dp

        # The maximum sum divisible by three will be in dp[0]
        return dp[0]