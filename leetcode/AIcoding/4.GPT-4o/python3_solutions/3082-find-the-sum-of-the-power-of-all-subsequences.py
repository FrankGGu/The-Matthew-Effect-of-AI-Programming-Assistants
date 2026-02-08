class Solution:
    def sumOfPower(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        nums.sort()
        total_sum = 0
        power_sum = 0
        n = len(nums)

        for i in range(n):
            power_sum = (power_sum * 2 + nums[i]) % MOD
            total_sum = (total_sum + power_sum) % MOD

        return total_sum