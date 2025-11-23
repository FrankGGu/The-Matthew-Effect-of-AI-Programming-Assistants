class Solution:
    def maxNonOverlapping(self, nums: List[int], target: int) -> int:
        prefix_sum = {0: -1}
        current_sum = 0
        result = 0
        last_end = -1

        for i, num in enumerate(nums):
            current_sum += num
            if (current_sum - target) in prefix_sum and prefix_sum[current_sum - target] >= last_end:
                result += 1
                last_end = i
            prefix_sum[current_sum] = i

        return result