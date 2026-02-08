class Solution:
    def beautifulArray(self, n: int) -> List[int]:
        if n == 1:
            return [1]
        left = self.beautifulArray((n + 1) // 2)
        right = self.beautifulArray(n // 2)
        return [2 * x - 1 for x in left] + [2 * x for x in right]