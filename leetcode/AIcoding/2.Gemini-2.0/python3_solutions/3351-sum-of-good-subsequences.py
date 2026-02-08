class Solution:
    def sumOfGoodSubsequences(self, nums: List[int]) -> int:
        mod = 10**9 + 7
        n = len(nums)
        ans = 0
        for i in range(n):
            if nums[i] <= n:
                ans = (ans + nums[i]) % mod

        power_of_2 = 1
        for i in range(1, n):
            power_of_2 = (power_of_2 * 2) % mod

        return (ans + power_of_2 -1) % mod