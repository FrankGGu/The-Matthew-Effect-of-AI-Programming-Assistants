class Solution:
    def sumOfPower(self, nums: List[int]) -> int:
        nums.sort()
        res = 0
        mod = 10**9 + 7
        prefix_sum = 0
        for num in nums:
            res = (res + num * (num * num) + num * (2 * prefix_sum)) % mod
            prefix_sum = (prefix_sum + num) % mod
        return res