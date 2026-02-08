import math

class Solution:
    def maxScore(self, nums: list[int]) -> int:
        n = len(nums)

        # max_mask will be (1 << n), representing all possible subsets of nums.
        max_mask = 1 << n

        # dp[mask] stores the maximum score achievable using the numbers
        # represented by the set bits in 'mask'.
        # Initialize dp array with zeros. dp[0] = 0 (no numbers used, no score).
        dp = [0] * max_mask

        # Iterate through all possible masks from 0 up to (1 << n) - 1.
        # A mask represents the set of numbers that have been used.
        for mask in range(max_mask):
            # Calculate the number of elements used so far (count of set bits in mask).
            num_elements_used = bin(mask).count('1')

            # If an odd number of elements have been used, this mask is invalid
            # because we always pick numbers in pairs.
            if num_elements_used % 2 != 0:
                continue

            # Calculate the current operation number.
            # If 'k' elements are used, 'k/2' operations have been performed.
            # The next operation will be (k/2) + 1.
            current_op_num = num_elements_used // 2 + 1

            # If we have already performed 'n/2' operations (where n = len(nums)),
            # then no more operations can be done for this mask.
            if current_op_num > n // 2:
                continue

            # Find the first available number (bit not set in mask).
            # This optimization ensures that each pair (i, j) is considered only once
            # when i is the smallest index of an unused number.
            first_available_idx = -1
            for i in range(n):
                if not (mask & (1 << i)): # If i-th bit is not set in mask
                    first_available_idx = i
                    break

            # If first_available_idx is -1, it means all numbers are used in this mask.
            # No more pairs can be picked from this state.
            if first_available_idx == -1:
                continue

            # Find the second available number (bit not set in mask) with an index
            # greater than first_available_idx.
            for second_available_idx in range(first_available_idx + 1, n):
                if not (mask & (1 << second_available_idx)): # If second_available_idx-th bit is not set

                    # Form the new mask by including the two chosen numbers.
                    new_mask = mask | (1 << first_available_idx) | (1 << second_available_idx)

                    # Calculate the score for this pair.
                    score_for_this_pair = current_op_num * math.gcd(nums[first_available_idx], nums[second_available_idx])

                    # Update the maximum score for the new_mask.
                    # We take the maximum of the current value of dp[new_mask]
                    # and the score obtained by adding this pair to dp[mask].
                    dp[new_mask] = max(dp[new_mask], dp[mask] + score_for_this_pair)

        # The final answer is the maximum score when all numbers have been used,
        # which corresponds to the mask where all bits are set: (1 << n) - 1.
        return dp[(1 << n) - 1]