class Solution:
    def permute(self, nums: List[int]) -> List[int]:
        n = len(nums)
        perm = [0] * n
        for i in range(n):
            perm[i] = nums[nums[i] - 1]
        return perm