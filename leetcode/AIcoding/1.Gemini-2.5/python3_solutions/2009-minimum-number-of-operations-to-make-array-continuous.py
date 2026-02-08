class Solution:
    def minOperations(self, nums: list[int]) -> int:
        n = len(nums)

        unique_nums = sorted(list(set(nums)))

        min_ops = n

        left = 0
        right = 0
        m = len(unique_nums)

        while left < m:
            target_end = unique_nums[left] + n - 1
            while right < m and unique_nums[right] <= target_end:
                right += 1

            current_count = right - left

            min_ops = min(min_ops, n - current_count)

            left += 1

        return min_ops