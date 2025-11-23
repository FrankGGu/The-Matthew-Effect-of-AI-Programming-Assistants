class Solution:
    def sumSubseqWidths(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        nums.sort()
        n = len(nums)
        pow2 = [1] * n
        for i in range(1, n):
            pow2[i] = pow2[i-1] * 2 % MOD

        res = 0
        for i in range(n):
            res = (res + nums[i] * (pow2[i] - pow2[n - 1 - i])) % MOD
        return res