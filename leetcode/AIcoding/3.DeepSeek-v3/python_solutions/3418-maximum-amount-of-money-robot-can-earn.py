class Solution:
    def maxMoney(self, n: int, k: int) -> int:
        total = n * (n + 1) // 2
        m = int((2 * k) ** 0.5)
        while m * (m + 1) // 2 <= k:
            m += 1
        while m * (m + 1) // 2 > k:
            m -= 1
        if m * (m + 1) // 2 == k:
            return total - 1
        return total