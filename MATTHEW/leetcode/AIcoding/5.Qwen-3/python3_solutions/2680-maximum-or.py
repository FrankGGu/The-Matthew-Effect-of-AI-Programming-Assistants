class Solution:
    def maximumOr(self, nums: List[int]) -> int:
        n = len(nums)
        max_or = 0
        for i in range(n):
            or_val = 0
            for j in range(i, n):
                or_val |= nums[j]
                max_or = max(max_or, or_val)
        return max_or