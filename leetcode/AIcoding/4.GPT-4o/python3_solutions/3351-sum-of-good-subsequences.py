class Solution:
    def sumOfGoodSubsequences(self, nums: List[int]) -> int:
        mod = 10**9 + 7
        total = 0
        count = 0
        for num in sorted(set(nums)):
            occurrences = nums.count(num)
            total = (total * (1 + pow(2, occurrences, mod) - 1) + num * count * pow(2, occurrences, mod)) % mod
            count = (count + occurrences * pow(2, count, mod)) % mod
        return total