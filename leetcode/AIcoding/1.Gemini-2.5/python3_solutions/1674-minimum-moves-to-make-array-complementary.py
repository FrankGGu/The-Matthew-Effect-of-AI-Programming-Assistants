import collections

class Solution:
    def minMoves(self, nums: List[int], limit: int) -> int:
        n = len(nums)

        # diff array to store changes in moves for each possible sum k
        # k can range from 2 to 2 * limit
        # Array size 2*limit + 2 to handle indices up to 2*limit + 1
        diff = [0] * (2 * limit + 2)

        # Initial assumption: all n/2 pairs require 2 moves each.
        # So, total moves = n.
        # We will subtract from this base cost.

        for i in range(n // 2):
            v1 = nums[i]
            v2 = nums[n - 1 - i]

            # Ensure a <= b for consistent logic
            a = min(v1, v2)
            b = max(v1, v2)

            # For a given pair (a, b) and target sum k:
            # 1. If k = a + b, 0 moves needed.
            # 2. If k is in [a + 1, b + limit] (but not a + b), 1 move needed.
            #    (e.g., change 'a' to 'k - b' or 'b' to 'k - a')
            # 3. Otherwise (k < a + 1 or k > b + limit), 2 moves needed.
            #    (e.g., change both 'a' and 'b')

            # All sums k initially contribute 2 moves for this pair.
            # We use the diff array to mark when the cost decreases.

            # For sums k in [a + 1, b + limit], the cost for this pair decreases from 2 to 1.
            # This is a reduction of 1 move.
            diff[a + 1] -= 1
            diff[b + limit + 1] += 1

            # For sum k = a + b, the cost for this pair decreases from 1 to 0.
            # This is an additional reduction of 1 move.
            diff[a + b] -= 1
            diff[a + b + 1] += 1

        # Initialize current_moves with the base cost (all pairs need 2 moves)
        current_moves = n 
        min_moves = n # Initialize min_moves with the worst case

        # Iterate through all possible target sums k
        for k in range(2, 2 * limit + 1):
            # Apply the accumulated changes for sum k
            current_moves += diff[k]
            # Update the minimum moves found so far
            min_moves = min(min_moves, current_moves)

        return min_moves