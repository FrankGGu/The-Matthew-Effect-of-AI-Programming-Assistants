class Solution:
    def concatenatedBinary(self, n: int) -> int:
        mod = 10**9 + 7
        result = 0
        length = 0

        for i in range(1, n + 1):
            if i == 2 ** length:
                length += 1
            result = ((result << length) | i) % mod

        return result