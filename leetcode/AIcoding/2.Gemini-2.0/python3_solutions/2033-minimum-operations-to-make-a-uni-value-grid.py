class Solution:
    def minOperations(self, grid: List[List[int]], x: int) -> int:
        nums = []
        for row in grid:
            nums.extend(row)
        nums.sort()
        n = len(nums)
        median = nums[n // 2]

        ops = 0
        for num in nums:
            diff = abs(num - median)
            if diff % x != 0:
                return -1
            ops += diff // x

        return ops