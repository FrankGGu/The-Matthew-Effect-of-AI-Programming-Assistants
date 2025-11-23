import math

class Solution:
    def findMaximumSequenceValue(self, nums: list[int]) -> int:
        n = len(nums)

        prefix_max = [0] * n
        prefix_min = [0] * n
        prefix_max[0] = nums[0]
        prefix_min[0] = nums[0]
        for i in range(1, n):
            prefix_max[i] = max(prefix_max[i-1], nums[i])
            prefix_min[i] = min(prefix_min[i-1], nums[i])

        suffix_max = [0] * n
        suffix_min = [0] * n
        suffix_max[n-1] = nums[n-1]
        suffix_min[n-1] = nums[n-1]
        for i in range(n - 2, -1, -1):
            suffix_max[i] = max(suffix_max[i+1], nums[i])
            suffix_min[i] = min(suffix_min[i+1], nums[i])

        max_sequence_value = -math.inf

        for j in range(1, n - 1):
            val_j = nums[j]

            max_i_val = prefix_max[j-1]
            min_i_val = prefix_min[j-1]

            max_k_val = suffix_max[j+1]
            min_k_val = suffix_min[j+1]

            if max_k_val >= 0:
                max_sequence_value = max(max_sequence_value, (max_i_val - val_j) * max_k_val)
            else: 
                max_sequence_value = max(max_sequence_value, (min_i_val - val_j) * max_k_val)

            if min_k_val >= 0:
                max_sequence_value = max(max_sequence_value, (max_i_val - val_j) * min_k_val)
            else: 
                max_sequence_value = max(max_sequence_value, (min_i_val - val_j) * min_k_val)

        return max_sequence_value