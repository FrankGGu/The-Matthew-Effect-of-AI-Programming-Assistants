class Solution:
    def concatenatedBinary(self, n: int) -> int:
        MOD = 10**9 + 7
        res = 0
        for num in range(1, n + 1):
            res = (res << num.bit_length()) | num
            res %= MOD
        return res