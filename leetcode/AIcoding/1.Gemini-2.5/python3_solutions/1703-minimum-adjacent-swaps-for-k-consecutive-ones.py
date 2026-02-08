class Solution:
    def minMoves(self, nums: list[int], k: int) -> int:
        positions = []
        for i, num in enumerate(nums):
            if num == 1:
                positions.append(i)

        n_ones = len(positions)

        if k == 1:
            return 0

        P_vals = [positions[i] - i for i in range(n_ones)]

        prefix_sum_P = [0] * (n_ones + 1)
        for i in range(n_ones):
            prefix_sum_P[i+1] = prefix_sum_P[i] + P_vals[i]

        min_cost = float('inf')

        for j in range(n_ones - k + 1):
            mid_idx = j + k // 2
            median_val = P_vals[mid_idx]

            left_count = mid_idx - j
            left_sum = prefix_sum_P[mid_idx] - prefix_sum_P[j]
            cost_left = left_count * median_val - left_sum

            right_count = (j + k) - mid_idx
            right_sum = prefix_sum_P[j+k] - prefix_sum_P[mid_idx]
            cost_right = right_sum - right_count * median_val

            current_cost = cost_left + cost_right
            min_cost = min(min_cost, current_cost)

        return min_cost