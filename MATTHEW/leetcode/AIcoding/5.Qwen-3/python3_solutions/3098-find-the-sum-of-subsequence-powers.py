class Solution:
    def sumOfSubsequencePowers(self, nums: list[int]) -> int:
        mod = 10**9 + 7
        result = 0
        n = len(nums)
        for i in range(n):
            count = 0
            for j in range(i, n):
                count += 1
                result = (result + nums[j] * pow(2, count - 1, mod)) % mod
        return result