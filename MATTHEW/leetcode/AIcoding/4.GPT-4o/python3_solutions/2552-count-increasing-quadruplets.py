class Solution:
    def countQuadruplets(self, nums: List[int]) -> int:
        count = 0
        n = len(nums)
        for k in range(3, n):
            for j in range(k):
                for i in range(j):
                    if nums[i] + nums[j] + nums[k] == 0:
                        count += 1
        return count