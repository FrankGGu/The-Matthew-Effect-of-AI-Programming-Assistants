import math

class Solution:
    def minChanges(self, nums: list[int], k: int) -> int:
        n = len(nums)

        # delta array to store the changes in the number of saved operations
        # for each target difference 'd'.
        # The size is k + 2 because 'd' can range from 0 to k (inclusive),
        # and we need to handle indices up to k + 1 for interval endpoints.
        delta = [0] * (k + 2) 

        num_pairs = n // 2

        for i in range(num_pairs):
            a = nums[i]
            b = nums[n - 1 - i]

            # Ensure x is the smaller value and y is the larger value
            x = min(a, b)
            y = max(a, b)

            # The current difference for this pair
            diff = y - x

            # max_k_for_one_change:
            # This is the maximum possible difference 'd' that can be achieved
            # by changing only one element (either x or y) to a value in [1, k].
            # If we change x to x' (1 <= x' <= k), the new difference is |x' - y|.
            # The range of |x' - y| is [0, max(y-1, k-y)].
            # If we change y to y' (1 <= y' <= k), the new difference is |x - y'|.
            # The range of |x - y'| is [0, max(x-1, k-x)].
            # So, the maximum 'd' for which one change is sufficient is
            # max(y-1, k-y, x-1, k-x).
            # Since x <= y, we have x-1 <= y-1 and k-x >= k-y.
            # Thus, this simplifies to max(y-1, k-x).
            max_k_for_one_change = max(y - 1, k - x)

            # For each pair (x, y), we consider the number of operations saved
            # compared to the worst case of 2 changes per pair.

            # 1. For any target difference 'd' in the range [0, max_k_for_one_change],
            #    we can achieve 'd' by changing only one element. This saves 1 operation
            #    compared to the base cost of 2 operations (changing both).
            #    Apply +1 to saved operations for the range [0, max_k_for_one_change].
            delta[0] += 1
            delta[max_k_for_one_change + 1] -= 1

            # 2. If the target difference 'd' is equal to the current difference 'diff' (y - x),
            #    we need 0 changes. This saves an additional 1 operation compared to the 1-change cost.
            #    Apply another +1 to saved operations specifically for 'd = diff'.
            delta[diff] += 1
            delta[diff + 1] -= 1

        current_saved_operations = 0
        max_saved_operations = 0 # Initialize to 0, as saved operations can be 0 or positive

        # Calculate prefix sums to find the total saved operations for each target difference 'd'
        for d in range(k + 1): # Iterate 'd' from 0 to k
            current_saved_operations += delta[d]
            max_saved_operations = max(max_saved_operations, current_saved_operations)

        # The minimum number of changes required across all pairs for any target 'd'
        # is the total possible changes minus the maximum number of operations saved.
        # Total possible changes = num_pairs * 2 (as each pair needs at most 2 changes).
        return (num_pairs * 2) - max_saved_operations