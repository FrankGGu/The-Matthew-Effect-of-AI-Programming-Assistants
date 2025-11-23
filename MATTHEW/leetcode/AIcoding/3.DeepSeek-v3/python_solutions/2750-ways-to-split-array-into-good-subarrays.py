class Solution:
    def numberOfGoodSubarraySplits(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        ones = []
        for i, num in enumerate(nums):
            if num == 1:
                ones.append(i)
        if not ones:
            return 0
        res = 1
        for i in range(1, len(ones)):
            res *= (ones[i] - ones[i-1])
            res %= MOD
        return res