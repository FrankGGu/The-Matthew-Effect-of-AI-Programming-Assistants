class Solution:
    def maxSizeSlices(self, slices: list[int]) -> int:
        n = len(slices)
        num_to_pick = n // 3

        # Case 1: Exclude the last slice (slices[n-1])
        # Consider slices[0...n-2]
        res1 = self._max_slices_linear(slices[0:n-1], num_to_pick)

        # Case 2: Exclude the first slice (slices[0])
        # Consider slices[1:n]
        res2 = self._max_slices_linear(slices[1:n], num_to_pick)

        return max(res1, res2)

    def _max_slices_linear(self, slices_list: list[int], num_to_pick: int) -> int:
        m = len(slices_list)
        if m == 0 or num_to_pick == 0:
            return 0

        # dp_prev[i] stores max sum picking j-1 slices from slices_list[0...i-1]
        # next_dp_row[i] stores max sum picking j slices from slices_list[0...i-1]

        # Initialize dp_prev to represent the base case for 0 slices picked (all 0s)
        dp_prev = [0] * (m + 1) 

        for j in range(1, num_to_pick + 1):
            next_dp_row = [0] * (m + 1) # Initialize for current j

            for i in range(1, m + 1):
                # Option 1: Don't pick slices_list[i-1]
                next_dp_row[i] = next_dp_row[i-1]

                # Option 2: Pick slices_list[i-1]
                current_slice_val = slices_list[i-1]

                prev_sum_for_pick = -float('inf')

                if i >= 2: # To pick slices_list[i-1], we must have picked j-1 slices from slices_list[0...i-3]
                    # This corresponds to dp[j-1][i-2], which is dp_prev[i-2]
                    prev_sum_for_pick = dp_prev[i-2]
                elif i == 1 and j == 1: # Special case: picking the very first slice, and it's the only one we need
                    prev_sum_for_pick = 0 # No previous slices needed for dp[0][...]
                # else: prev_sum_for_pick remains -float('inf'), indicating an invalid state

                if prev_sum_for_pick != -float('inf'):
                    next_dp_row[i] = max(next_dp_row[i], current_slice_val + prev_sum_for_pick)

            # After computing the entire row for current j, update dp_prev for next iteration
            dp_prev = next_dp_row

    # The result for num_to_pick slices from m elements is in dp_prev[m]
    return dp_prev[m]