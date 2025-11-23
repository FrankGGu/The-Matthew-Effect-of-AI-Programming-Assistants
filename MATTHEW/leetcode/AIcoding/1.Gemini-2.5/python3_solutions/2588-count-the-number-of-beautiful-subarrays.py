from collections import defaultdict

class Solution:
    def numberOfSubarrays(self, nums: list[int], k: int) -> int:
        count = 0
        current_odd_count = 0
        freq = defaultdict(int)
        freq[0] = 1  # Represents an empty prefix sum having 0 odd numbers

        for num in nums:
            if num % 2 != 0:  # If num is odd
                current_odd_count += 1

            # If current_odd_count - k exists in freq, it means there are
            # freq[current_odd_count - k] subarrays ending at the current position
            # that have exactly k odd numbers.
            if (current_odd_count - k) in freq:
                count += freq[current_odd_count - k]

            freq[current_odd_count] += 1

        return count