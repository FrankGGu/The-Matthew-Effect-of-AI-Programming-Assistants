class Solution:
    def matrixSum(self, nums: List[List[int]]) -> int:
        for row in nums:
            row.sort(reverse=True)
        total = 0
        for i in range(len(nums[0])):
            max_val = max(row[i] for row in nums)
            total += max_val
        return total