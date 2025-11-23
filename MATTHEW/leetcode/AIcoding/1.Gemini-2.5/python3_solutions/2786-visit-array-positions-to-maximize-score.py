class Solution:
    def maxScore(self, nums: list[int], x: int) -> int:
        # dp[0] will store the maximum score ending at an even number
        # dp[1] will store the maximum score ending at an odd number
        # Initialize with negative infinity as we are looking for maximums.
        # The initial score is nums[0].

        dp = [-float('inf'), -float('inf')]

        # Set the initial score based on the parity of nums[0]
        dp[nums[0] % 2] = nums[0]

        # Iterate through the array starting from the second element
        for i in range(1, len(nums)):
            current_num = nums[i]
            current_parity = current_num % 2
            other_parity = 1 - current_parity

            # Calculate the score if we jump from a previous number with the same parity
            # If dp[current_parity] is -inf, it means no valid path to a same-parity number existed yet,
            # so this path is also -inf.
            score_from_same_parity = dp[current_parity] + current_num

            # Calculate the score if we jump from a previous number with different parity
            # We incur a penalty 'x' for changing parity.
            # If dp[other_parity] is -inf, this path is also -inf.
            score_from_other_parity = dp[other_parity] + current_num - x

            # The maximum score if we choose to end our path at current_num
            max_score_ending_at_current_num = max(score_from_same_parity, score_from_other_parity)

            # Update dp[current_parity] with the maximum score ending at any number
            # of current_parity encountered so far (including current_num).
            dp[current_parity] = max(dp[current_parity], max_score_ending_at_current_num)

        # The maximum score achievable will be the maximum of the two dp states
        return max(dp)