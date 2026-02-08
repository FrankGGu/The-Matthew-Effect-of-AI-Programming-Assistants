from typing import List

class Solution:
    def sumDigitDifferences(self, nums: List[int]) -> int:
        total_sum_of_differences = 0
        current_power_of_10 = 1

        # Iterate through each digit position, from units place (0) up to the highest possible digit place.
        # Since nums[i] can be up to 10^9, numbers can have up to 10 digits (0-9).
        # We perform this for 10 digit positions.
        for _ in range(10): 
            # counts[d] will store how many numbers in `nums` have digit `d` at the current digit position.
            counts = [0] * 10 

            # Populate counts for the current digit position
            for num in nums:
                digit = (num // current_power_of_10) % 10
                counts[digit] += 1

            # Calculate the sum of digit differences for the current position
            current_position_diff_sum = 0
            # Iterate through all possible pairs of digits (d1, d2)
            for d1 in range(10):
                for d2 in range(d1 + 1, 10): # Ensure d2 > d1 to avoid double counting and d1=d2 (difference would be 0)
                    # For each pair of distinct digits (d1, d2), calculate their contribution.
                    # There are counts[d1] numbers with digit d1 and counts[d2] numbers with digit d2.
                    # The number of pairs (x, y) where digit_at_pos(x) = d1 and digit_at_pos(y) = d2 is counts[d1] * counts[d2].
                    # The absolute difference for these pairs is (d2 - d1) since d2 > d1.
                    current_position_diff_sum += counts[d1] * counts[d2] * (d2 - d1)

            total_sum_of_differences += current_position_diff_sum

            # Move to the next digit position (tens, hundreds, thousands, etc.)
            current_power_of_10 *= 10

        return total_sum_of_differences