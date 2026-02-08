class Solution:
    def countSpecialSubsequences(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        a = b = c = 0
        for num in nums:
            if num == 0:
                a = (2 * a + 1) % MOD
            elif num == 1:
                b = (2 * b + a) % MOD
            else:
                c = (2 * c + b) % MOD
        return c