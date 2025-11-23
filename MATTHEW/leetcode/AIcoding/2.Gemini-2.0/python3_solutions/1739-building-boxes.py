import math

class Solution:
    def minimumBoxes(self, n: int) -> int:
        k = 0
        while k * (k + 1) * (k + 2) // 6 < n:
            k += 1
        k -= 1
        n -= k * (k + 1) * (k + 2) // 6

        res = k * (k + 1) // 2

        l = 0
        while l * (l + 1) // 2 < n:
            l += 1
        l -= 1

        res += (l + 1)

        return res