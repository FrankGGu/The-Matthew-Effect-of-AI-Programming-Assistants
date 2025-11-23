import collections

class Solution:
    def maxTotalFruits(self, fruits: list[list[int]], startPos: int, k: int) -> int:

        fruits_map = collections.defaultdict(int)
        for p, a in fruits:
            fruits_map[p] += a

        sorted_positions = sorted(fruits_map.keys())

        prefix_sums = [0] * (len(sorted_positions) + 1)
        for i in range(len(sorted_positions)):
            prefix_sums[i+1] = prefix_sums[i] + fruits_map[sorted_positions[i]]

        max_fruits = 0
        left_idx = 0
        n = len(sorted_positions)

        for right_idx in range(n):
            R_pos = sorted_positions[right_idx]

            while left_idx <= right_idx:
                L_pos = sorted_positions[left_idx]

                steps_needed = 0
                if startPos <= L_pos:
                    # Case: startPos is to the left of or at L_pos.
                    # Path: startPos -> L_pos -> R_pos
                    steps_needed = (L_pos - startPos) + (R_pos - L_pos)
                elif startPos >= R_pos:
                    # Case: startPos is to the right of or at R_pos.
                    # Path: startPos -> R_pos -> L_pos
                    steps_needed = (startPos - R_pos) + (R_pos - L_pos)
                else:
                    # Case: startPos is between L_pos and R_pos.
                    # Option 1: startPos -> L_pos -> R_pos
                    steps1 = (startPos - L_pos) + (R_pos - L_pos)
                    # Option 2: startPos -> R_pos -> L_pos
                    steps2 = (R_pos - startPos) + (R_pos - L_pos)
                    steps_needed = min(steps1, steps2)

                if steps_needed <= k:
                    current_fruits = prefix_sums[right_idx + 1] - prefix_sums[left_idx]
                    max_fruits = max(max_fruits, current_fruits)
                    break # This window is valid, try to expand R_pos
                else:
                    left_idx += 1 # This window is too wide, shrink from left

        return max_fruits