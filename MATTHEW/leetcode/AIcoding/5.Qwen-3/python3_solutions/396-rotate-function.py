class Solution:
    def maxRotateFunction(self, nums: List[int]) -> int:
        n = len(nums)
        total = sum(nums)
        current = 0
        for i in range(n):
            current += i * nums[i]
        max_val = current
        for i in range(1, n):
            current = current + total - n * nums[n - i]
            if current > max_val:
                max_val = current
        return max_val