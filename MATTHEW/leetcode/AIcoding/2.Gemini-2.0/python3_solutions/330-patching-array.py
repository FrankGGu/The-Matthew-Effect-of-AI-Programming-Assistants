class Solution:
    def minPatches(self, nums: list[int], n: int) -> int:
        patches = 0
        covered_range = 0
        i = 0
        while covered_range < n:
            if i < len(nums) and nums[i] <= covered_range + 1:
                covered_range += nums[i]
                i += 1
            else:
                covered_range += covered_range + 1
                patches += 1
        return patches