class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        res = 0
        for i in range(n - 1):
            if nums[i] == 1:
                continue
            res += 1
            nums[i] ^= 1
            nums[i + 1] ^= 1
        if nums[-1] == 1:
            return res
        return -1