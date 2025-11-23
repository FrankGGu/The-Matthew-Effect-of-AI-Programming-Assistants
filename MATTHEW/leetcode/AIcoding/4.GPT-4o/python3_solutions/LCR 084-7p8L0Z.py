class Solution:
    def permuteUnique(self, nums: List[int]) -> List[List[int]]:
        def backtrack(start):
            if start == len(nums):
                res.add(tuple(nums[:]))
            for i in range(start, len(nums)):
                nums[start], nums[i] = nums[i], nums[start]
                backtrack(start + 1)
                nums[start], nums[i] = nums[i], nums[start]

        res = set()
        nums.sort()
        backtrack(0)
        return list(map(list, res))