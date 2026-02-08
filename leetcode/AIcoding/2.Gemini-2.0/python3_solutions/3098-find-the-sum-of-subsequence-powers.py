class Solution:
    def sumOfPower(self, nums: List[int]) -> int:
        nums.sort()
        res = 0
        power_sum = 0
        MOD = 10**9 + 7
        for num in nums:
            res = (res + (num * num) % MOD * (num + power_sum) % MOD) % MOD
            power_sum = (2 * power_sum + num) % MOD
        return res