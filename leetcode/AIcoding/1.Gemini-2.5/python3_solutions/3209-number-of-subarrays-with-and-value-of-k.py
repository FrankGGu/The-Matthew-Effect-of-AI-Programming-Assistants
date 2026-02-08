from typing import List

class Solution:
    def subarraysWithAndValueK(self, nums: List[int], k: int) -> int:
        n = len(nums)
        count = 0

        # current_ands is a dictionary that stores the counts of subarrays ending at the
        # previous index (r-1) with a specific AND value.
        # Format: {AND_value: count_of_subarrays}
        current_ands = {} 

        for r in range(n):
            # new_ands will store the counts of subarrays ending at the current index 'r'
            # with specific AND values.
            new_ands = {}

            # 1. Consider the subarray consisting of only nums[r] itself.
            # Its AND value is nums[r].
            new_ands[nums[r]] = 1

            # 2. Extend subarrays that ended at (r-1) by including nums[r].
            # For each (AND_value, count) pair from the previous step:
            for prev_val, prev_count in current_ands.items():
                # The new AND value for these extended subarrays is (previous_AND_value & nums[r]).
                extended_val = prev_val & nums[r]

                # Add their counts to the new_ands map.
                # If extended_val already exists, add to its count; otherwise, initialize.
                new_ands[extended_val] = new_ands.get(extended_val, 0) + prev_count

            # Update current_ands for the next iteration (r+1).
            current_ands = new_ands

            # Add the count of subarrays ending at 'r' that have an AND value equal to 'k'
            # to the total count. If 'k' is not in new_ands, get(k, 0) correctly returns 0.
            count += current_ands.get(k, 0)

        return count