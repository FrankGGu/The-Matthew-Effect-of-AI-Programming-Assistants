class Solution:
    def xSum(self, nums: List[int], k: int) -> int:
        n = len(nums)
        if n < k:
            return 0

        current_sum = sum(nums[:k])
        total_x_sum = current_sum

        for i in range(k, n):
            current_sum += nums[i] - nums[i - k]
            total_x_sum += current_sum

        return total_x_sum