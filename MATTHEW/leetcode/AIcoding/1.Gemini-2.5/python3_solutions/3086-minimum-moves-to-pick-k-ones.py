import math

class Solution:
    def minMoves(self, nums: list[int], k: int) -> int:
        pos = []
        for i, num in enumerate(nums):
            if num == 1:
                pos.append(i)

        n_ones = len(pos)

        # P_pos[j] stores sum(pos[0]...pos[j-1])
        P_pos = [0] * (n_ones + 1)
        for i in range(n_ones):
            P_pos[i+1] = P_pos[i] + pos[i]

        # P_j[x] stores sum(0, 1, ..., x-1)
        P_j = [0] * (n_ones + 1)
        for i in range(n_ones):
            P_j[i+1] = P_j[i] + i 

        min_total_cost = float('inf')

        # Iterate through all possible windows of k ones
        # A window is defined by pos[i]...pos[i+k-1]
        for i in range(n_ones - k + 1):
            # The median element's index in the 'pos' array (0-indexed relative to pos)
            m_idx_in_pos = i + k // 2

            # The value of the median one's position
            median_pos_val = pos[m_idx_in_pos]

            # The corresponding 'j' value for the median element in a 0-indexed window of k elements
            median_j_val = k // 2

            # C_opt is the optimal starting position for the contiguous block of k ones
            # C_opt = median(pos[i+j] - j for j in 0..k-1)
            # which simplifies to pos[i + k//2] - (k//2)
            C_opt = median_pos_val - median_j_val

            # Calculate sum of (pos[i+j] - j) for j from 0 to median_j_val-1 (left part)
            sum_left_pos_values = P_pos[m_idx_in_pos] - P_pos[i]
            sum_left_j_values = P_j[median_j_val] - P_j[0] 
            sum_left_z_values = sum_left_pos_values - sum_left_j_values

            # Calculate sum of (pos[i+j] - j) for j from median_j_val+1 to k-1 (right part)
            sum_right_pos_values = P_pos[i+k] - P_pos[m_idx_in_pos+1]
            sum_right_j_values = P_j[k] - P_j[median_j_val+1]
            sum_right_z_values = sum_right_pos_values - sum_right_j_values

            # Number of elements to the left of the median in the 'z' array
            num_left_z = median_j_val
            # Number of elements to the right of the median in the 'z' array
            num_right_z = k - 1 - median_j_val

            # Cost from the sum(|z_j - C_opt|) part
            cost_median_part = (num_left_z - num_right_z) * C_opt - sum_left_z_values + sum_right_z_values

            # Cost from the sum(C+j) part
            cost_k_C_part = k * C_opt
            cost_k_k_minus_1_part = k * (k - 1) // 2

            current_total_cost = cost_median_part + cost_k_C_part + cost_k_k_minus_1_part

            min_total_cost = min(min_total_cost, current_total_cost)

        return min_total_cost