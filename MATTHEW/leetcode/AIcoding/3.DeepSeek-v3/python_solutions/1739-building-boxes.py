class Solution:
    def minimumBoxes(self, n: int) -> int:
        k = 0
        total = 0
        while total + (k + 1) * (k + 2) // 2 <= n:
            total += (k + 1) * (k + 2) // 2
            k += 1

        res = k * (k + 1) // 2
        remaining = n - total
        if remaining == 0:
            return res

        m = int((2 * remaining) ** 0.5)
        while m * (m + 1) // 2 < remaining:
            m += 1
        return res + m