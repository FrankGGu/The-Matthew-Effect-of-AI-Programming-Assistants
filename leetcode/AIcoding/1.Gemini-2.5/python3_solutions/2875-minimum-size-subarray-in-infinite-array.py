import math

class Solution:
    def minSizeSubarray(self, nums: list[int], target: int) -> int:
        n = len(nums)
        total_sum = sum(nums)

        num_full_repetitions = target // total_sum
        remaining_target = target % total_sum

        ans = num_full_repetitions * n

        if remaining_target == 0:
            return ans

        extended_nums = nums + nums

        min_len_remaining = math.inf
        current_sum = 0
        left = 0

        for right in range(len(extended_nums)):
            current_sum += extended_nums[right]

            while current_sum > remaining_target:
                current_sum -= extended_nums[left]
                left += 1

            if current_sum == remaining_target:
                min_len_remaining = min(min_len_remaining, right - left + 1)

        if min_len_remaining == math.inf:
            return -1

        return ans + min_len_remaining