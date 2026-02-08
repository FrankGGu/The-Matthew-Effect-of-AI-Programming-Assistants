class Solution:
    def separateDigits(self, n: str) -> int:
        length = len(n)
        for i in range(1, length // 2 + 1):
            first = n[:i]
            second = str(int(first) + 1)
            if n[i:i+len(second)] == second:
                return 1 + self.separateDigits(n[i+len(second):])
        return 0

    def countOrders(self, n: str) -> int:
        return self.separateDigits(n)