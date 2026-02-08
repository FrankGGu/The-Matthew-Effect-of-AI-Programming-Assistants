class Solution:
    def sumSubseqWidths(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        ans = 0
        mod = 10**9 + 7
        power = [1] * n
        for i in range(1, n):
            power[i] = (power[i - 1] * 2) % mod
        for i in range(n):
            ans = (ans + (nums[i] * power[i]) % mod - (nums[i] * power[n - 1 - i]) % mod) % mod
        return (ans + mod) % mod