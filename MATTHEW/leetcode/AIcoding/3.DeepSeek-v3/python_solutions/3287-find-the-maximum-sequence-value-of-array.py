class Solution:
    def maximumSequenceValue(self, nums: List[int]) -> int:
        if len(nums) == 1:
            return nums[0]
        max_val = 0
        n = len(nums)
        for i in range(n):
            for j in range(i + 1, n):
                current = abs(nums[i] - nums[j]) + abs(i - j)
                if current > max_val:
                    max_val = current
        return max_val