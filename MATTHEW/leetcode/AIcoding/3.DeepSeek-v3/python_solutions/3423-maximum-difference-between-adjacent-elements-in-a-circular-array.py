class Solution:
    def maxDifference(self, nums: List[int]) -> int:
        n = len(nums)
        max_diff = -1

        for i in range(n):
            current = nums[i]
            next_num = nums[(i + 1) % n]
            if next_num > current:
                max_diff = max(max_diff, next_num - current)

        return max_diff