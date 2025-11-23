class Solution:
    def minimumSum(self, nums: List[int]) -> int:
        n = len(nums)
        min_sum = float('inf')

        for i in range(1, n - 1):
            left = max(nums[:i])
            right = max(nums[i+1:])
            current_sum = left + nums[i] + right
            if current_sum < min_sum:
                min_sum = current_sum

        return min_sum