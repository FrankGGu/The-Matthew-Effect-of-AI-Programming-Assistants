class Solution:
    def sumOfPower(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        result = 0
        for i in range(n):
            power = 1
            for j in range(i, n):
                power = (power * nums[j]) % MOD
                result = (result + power) % MOD
        return result