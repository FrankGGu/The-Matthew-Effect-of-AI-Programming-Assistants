class Solution:
    def waysToSplitArray(self, nums: list[int]) -> int:
        MOD = 10**9 + 7

        ones_indices = []
        for i, num in enumerate(nums):
            if num == 1:
                ones_indices.append(i)

        if not ones_indices:
            return 0

        if len(ones_indices) == 1:
            return 1

        ways = 1
        for i in range(len(ones_indices) - 1):
            diff = ones_indices[i+1] - ones_indices[i]
            ways = (ways * diff) % MOD

        return ways