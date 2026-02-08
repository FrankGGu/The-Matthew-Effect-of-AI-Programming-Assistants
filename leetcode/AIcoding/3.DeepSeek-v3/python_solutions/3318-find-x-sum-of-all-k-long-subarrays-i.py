class Solution:
    def getXSum(self, nums: List[int], k: int) -> int:
        n = len(nums)
        if n == 0 or k == 0:
            return 0
        res = 0
        current_xor = 0
        for i in range(n):
            current_xor ^= nums[i]
            if i >= k - 1:
                res += current_xor
                current_xor ^= nums[i - k + 1]
        return res