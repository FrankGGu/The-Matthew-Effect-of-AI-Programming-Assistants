class Solution:
    def beautifulArray(self, n: int) -> list[int]:
        if n == 1:
            return [1]
        even = self.beautifulArray(n // 2)
        odd = self.beautifulArray((n + 1) // 2)
        return [2 * x for x in odd] + [2 * x - 1 for x in even]