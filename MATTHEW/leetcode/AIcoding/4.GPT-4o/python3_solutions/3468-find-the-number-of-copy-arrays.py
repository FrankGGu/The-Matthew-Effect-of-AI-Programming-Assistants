class Solution:
    def countCopyArrays(self, nums: List[int]) -> int:
        n = len(nums)
        MOD = 10**9 + 7
        nums.sort()

        result = 1
        for i in range(n):
            result = (result * (i + 1)) % MOD

        return result