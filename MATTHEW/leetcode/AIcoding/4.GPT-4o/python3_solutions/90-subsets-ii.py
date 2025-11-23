class Solution:
    def subsetsWithDup(self, nums: List[int]) -> List[List[int]]:
        nums.sort()
        res = []
        self.backtrack(nums, 0, [], res)
        return res

    def backtrack(self, nums, start, path, res):
        res.append(path)
        for i in range(start, len(nums)):
            if i > start and nums[i] == nums[i - 1]:
                continue
            self.backtrack(nums, i + 1, path + [nums[i]], res)