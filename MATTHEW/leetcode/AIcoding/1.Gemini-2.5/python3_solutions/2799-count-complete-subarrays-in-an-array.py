from collections import defaultdict

class Solution:
    def countCompleteSubarrays(self, nums: list[int]) -> int:
        n = len(nums)

        # Step 1: Find the total number of distinct elements in the entire array
        total_distinct_elements = len(set(nums))

        # Step 2: Use a sliding window to count subarrays with at least `total_distinct_elements` distinct elements.
        # Since `total_distinct_elements` is the maximum possible number of distinct elements in any subarray,
        # a subarray having "at least `total_distinct_elements`" distinct elements implies it has "exactly
        # `total_distinct_elements`" distinct elements.

        left = 0
        ans = 0
        distinct_in_window = 0
        freq = defaultdict(int)

        for right in range(n):
            # Add nums[right] to the window
            if freq[nums[right]] == 0:
                distinct_in_window += 1
            freq[nums[right]] += 1

            # While the current window has `total_distinct_elements` distinct elements,
            # it means `nums[left:right+1]` is a complete subarray.
            # Any subarray starting from `left` and ending at `right` or any index further to the right
            # (up to n-1) will also contain all `total_distinct_elements` distinct elements.
            # The number of such subarrays is (n - 1) - right + 1 = n - right.
            while distinct_in_window == total_distinct_elements:
                ans += (n - right)

                # Shrink the window from the left
                freq[nums[left]] -= 1
                if freq[nums[left]] == 0:
                    distinct_in_window -= 1
                left += 1

        return ans