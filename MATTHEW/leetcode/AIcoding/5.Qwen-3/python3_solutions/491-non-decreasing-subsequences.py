from typing import List

class Solution:
    def subsetsWithDup(self, nums: List[int]) -> List[List[int]]:
        nums.sort()
        res = []
        self.backtrack(nums, 0, [], res)
        return res

    def backtrack(self, nums: List[int], start: int, path: List[int], res: List[List[int]]):
        res.append(path[:])
        for i in range(start, len(nums)):
            if i > start and nums[i] == nums[i - 1]:
                continue
            path.append(nums[i])
            self.backtrack(nums, i + 1, path, res)
            path.pop()