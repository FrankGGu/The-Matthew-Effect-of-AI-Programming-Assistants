class Solution:
    def kSum(self, nums: List[int], k: int) -> List[List[int]]:
        def backtrack(start, k, target, path):
            if k == 0 and target == 0:
                res.append(path)
                return
            if k < 0 or target < 0:
                return
            for i in range(start, len(nums)):
                backtrack(i + 1, k - 1, target - nums[i], path + [nums[i]])

        res = []
        nums.sort()
        backtrack(0, k, sum(nums) - k * nums[0], [])
        return res