class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        flip = 0
        res = 0
        for i in range(n):
            if (nums[i] + flip) % 2 == 0:
                res += 1
                flip += 1
        return res