class Solution:
    def concatenatedBinary(self, n: int) -> int:
        mod = 10**9 + 7
        result = 0
        for i in range(1, n + 1):
            result = (result << (i.bit_length())) % mod
            result = (result + i) % mod
        return result