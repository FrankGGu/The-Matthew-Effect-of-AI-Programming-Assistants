class Solution:
    def maximumTripletValue(self, nums: list[int]) -> int:
        n = len(nums)

        if n < 3:
            return 0

        max_prefix = [0] * n
        max_prefix[0] = nums[0]
        for i in range(1, n):
            max_prefix[i] = max(max_prefix[i - 1], nums[i])

        max_suffix = [0] * n
        max_suffix[n - 1] = nums[n - 1]
        for i in range(n - 2, -1, -1):
            max_suffix[i] = max(max_suffix[i + 1], nums[i])

        max_val = 0

        for j in range(1, n - 1):
            max_i_val = max_prefix[j - 1]
            max_k_val = max_suffix[j + 1]

            current_triplet_value = (max_i_val - nums[j]) * max_k_val
            max_val = max(max_val, current_triplet_value)

        return max_val