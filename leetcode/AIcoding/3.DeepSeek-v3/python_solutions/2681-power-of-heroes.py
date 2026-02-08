class Solution:
    def sumOfPower(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        nums.sort()
        res = 0
        prev_sum = 0
        for num in nums:
            res = (res + num * num * (num + prev_sum)) % MOD
            prev_sum = (prev_sum * 2 + num) % MOD
        return res