class Solution:
    def maximumOr(self, nums: list[int], k: int) -> int:
        n = len(nums)

        prefix_or = [0] * n
        suffix_or = [0] * n

        prefix_or[0] = nums[0]
        for i in range(1, n):
            prefix_or[i] = prefix_or[i-1] | nums[i]

        suffix_or[n-1] = nums[n-1]
        for i in range(n - 2, -1, -1):
            suffix_or[i] = suffix_or[i+1] | nums[i]

        max_overall_or = 0

        for i in range(n):
            current_or_without_i = 0
            if i > 0:
                current_or_without_i |= prefix_or[i-1]
            if i < n - 1:
                current_or_without_i |= suffix_or[i+1]

            current_total_or = current_or_without_i | (nums[i] << k)

            max_overall_or = max(max_overall_or, current_total_or)

        return max_overall_or