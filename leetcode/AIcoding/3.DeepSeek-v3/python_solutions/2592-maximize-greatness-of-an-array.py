class Solution:
    def maximizeGreatness(self, nums: List[int]) -> int:
        nums.sort()
        res = 0
        for num in nums:
            if num > nums[res]:
                res += 1
        return res