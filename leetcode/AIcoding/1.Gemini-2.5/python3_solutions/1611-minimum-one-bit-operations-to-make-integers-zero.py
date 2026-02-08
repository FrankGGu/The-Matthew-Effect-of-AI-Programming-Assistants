class Solution:
    def minimumOneBitOperations(self, n: int) -> int:

        ans = 0
        sign = 1

        while n > 0:
            k = n.bit_length() - 1
            ans += sign * ((1 << (k + 1)) - 1)
            n -= (1 << k)
            sign *= -1

        return ans