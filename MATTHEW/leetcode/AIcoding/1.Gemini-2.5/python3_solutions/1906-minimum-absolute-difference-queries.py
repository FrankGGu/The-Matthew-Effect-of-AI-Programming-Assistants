from typing import List

class Solution:
    def minDifference(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        N = len(nums)

        # prefix_counts[i][j] stores the count of number j in nums[0...i-1]
        # The size is (N+1) x 101, where 101 accounts for values 1 to 100.
        prefix_counts = [[0] * 101 for _ in range(N + 1)]

        # Build the prefix_counts array
        # prefix_counts[0] remains all zeros, representing an empty prefix.
        for i in range(N):
            # Copy counts from the previous prefix sum (nums[0...i-1])
            for j in range(1, 101):
                prefix_counts[i+1][j] = prefix_counts[i][j]
            # Increment the count for the current number nums[i]
            # prefix_counts[i+1] now represents counts for nums[0...i]
            prefix_counts[i+1][nums[i]] += 1

        results = []
        for L, R in queries:
            min_diff = float('inf')
            last_val = -1  # Stores the last distinct value encountered in the range

            # Iterate through all possible values from 1 to 100
            for val in range(1, 101):
                # Check if 'val' is present in the range nums[L...R]
                # The count of 'val' in nums[L...R] is
                # prefix_counts[R+1][val] - prefix_counts[L][val]
                if (prefix_counts[R+1][val] - prefix_counts[L][val]) > 0:
                    # If 'val' is present and we have a previous distinct value
                    if last_val != -1:
                        min_diff = min(min_diff, val - last_val)
                    # Update last_val to the current distinct value
                    last_val = val

            # If min_diff is still infinity, it means there were fewer than two distinct elements
            # in the queried range, so the answer is -1.
            if min_diff == float('inf'):
                results.append(-1)
            else:
                results.append(min_diff)

        return results