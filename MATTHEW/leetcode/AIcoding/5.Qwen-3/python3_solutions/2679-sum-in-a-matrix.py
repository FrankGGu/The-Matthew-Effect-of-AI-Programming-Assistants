class Solution:
    def matrixSum(self, nums: List[List[int]]) -> int:
        for row in nums:
            row.sort()
        res = 0
        for j in range(len(nums[0])):
            max_val = 0
            for i in range(len(nums)):
                max_val = max(max_val, nums[i][j])
            res += max_val
        return res