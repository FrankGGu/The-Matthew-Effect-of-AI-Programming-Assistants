class Solution:
    def distinctDifferenceArray(self, nums: list[int]) -> list[int]:
        n = len(nums)
        diff = []
        for i in range(n):
            prefix_set = set(nums[:i+1])
            suffix_set = set(nums[i+1:])
            diff.append(len(prefix_set) - len(suffix_set))
        return diff