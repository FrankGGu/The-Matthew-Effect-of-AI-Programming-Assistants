class Solution:
    def findMaximumLength(self, nums: list[int]) -> int:
        # dp dictionary stores the maximum length of a valid subsequence ending with a specific value.
        # dp[value] = max_length
        dp = {}
        max_len = 0

        for num in nums:
            # Initialize the length of a subsequence ending with 'num' to 1 (for 'num' itself).
            current_max_len = 1

            # Check all 5 conditions for a potential previous element 'prev_val'
            # that could validly precede 'num' in a subsequence.

            # Condition 1: nums[i_j] == nums[i_{j+1}]
            # If 'num' itself was a previous element, we can extend that subsequence.
            if num in dp:
                current_max_len = max(current_max_len, dp[num] + 1)

            # Condition 2: nums[i_j] + 1 == nums[i_{j+1}]
            # This means the previous element 'prev_val' must be 'num - 1'.
            prev_val_minus_1 = num - 1
            if prev_val_minus_1 in dp:
                current_max_len = max(current_max_len, dp[prev_val_minus_1] + 1)

            # Condition 3: nums[i_j] - 1 == nums[i_{j+1}]
            # This means the previous element 'prev_val' must be 'num + 1'.
            prev_val_plus_1 = num + 1
            if prev_val_plus_1 in dp:
                current_max_len = max(current_max_len, dp[prev_val_plus_1] + 1)

            # Condition 4: nums[i_j] * 2 == nums[i_{j+1}]
            # This means the previous element 'prev_val' must be 'num / 2'.
            # This is only possible if 'num' is even.
            if num % 2 == 0:
                prev_val_half = num // 2
                if prev_val_half in dp:
                    current_max_len = max(current_max_len, dp[prev_val_half] + 1)

            # Condition 5: nums[i_j] / 2 == nums[i_{j+1}] (only if nums[i_j] is even)
            # This means the previous element 'prev_val' must be 'num * 2'.
            # The condition "only if nums[i_j] is even" is implicitly satisfied because 'num * 2' is always even.
            prev_val_double = num * 2
            if prev_val_double in dp:
                current_max_len = max(current_max_len, dp[prev_val_double] + 1)

            # Update dp[num]. If 'num' has appeared before, we take the maximum length
            # found so far ending at 'num' or the new 'current_max_len'.
            dp[num] = max(dp.get(num, 0), current_max_len)

            # Update the overall maximum length found across all subsequences.
            max_len = max(max_len, dp[num])

        return max_len