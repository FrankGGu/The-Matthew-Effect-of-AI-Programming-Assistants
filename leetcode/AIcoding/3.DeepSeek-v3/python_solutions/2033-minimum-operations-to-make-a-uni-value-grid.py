class Solution:
    def minOperations(self, grid: List[List[int]], x: int) -> int:
        nums = []
        for row in grid:
            nums.extend(row)
        nums.sort()
        median = nums[len(nums) // 2]
        operations = 0
        for num in nums:
            diff = abs(num - median)
            if diff % x != 0:
                return -1
            operations += diff // x
        return operations