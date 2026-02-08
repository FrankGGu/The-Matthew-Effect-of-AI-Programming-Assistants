class Solution:
    def numSub(self, s: str) -> int:
        MOD = 10**9 + 7
        res = 0
        current = 0

        for char in s:
            if char == '1':
                current += 1
                res += current
            else:
                current = 0

        return res % MOD