from collections import Counter

class Solution:
    def maximumSubarraySum(self, nums: list[int], k: int) -> int:
        n = len(nums)
        max_sum = 0
        current_sum = 0
        counts = Counter()

        for i in range(n):
            # Add the current element to the sliding window
            current_sum += nums[i]
            counts[nums[i]] += 1

            # Once the window has reached size k
            if i >= k - 1:
                # Check if all elements in the current window are distinct
                # This is true if the number of unique elements in 'counts' is equal to k
                if len(counts) == k:
                    max_sum = max(max_sum, current_sum)

                # Remove the element that is leaving the window (the leftmost element)
                element_to_remove = nums[i - (k - 1)]
                current_sum -= element_to_remove
                counts[element_to_remove] -= 1

                # If the count of the removed element becomes 0, remove it from the counter
                # This is crucial for `len(counts)` to accurately reflect the number of distinct elements
                if counts[element_to_remove] == 0:
                    del counts[element_to_remove]

        return max_sum