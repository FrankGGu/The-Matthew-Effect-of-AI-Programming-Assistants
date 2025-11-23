class Solution:
    def nonNegativeIntegers(self, n: int) -> int:
        if n < 2:
            return n + 1
        res = 0
        prev = 0
        curr = 1
        while curr <= n:
            res += curr
            prev, curr = curr, prev + curr
        return res