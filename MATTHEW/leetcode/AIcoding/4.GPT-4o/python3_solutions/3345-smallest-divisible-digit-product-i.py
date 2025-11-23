class Solution:
    def smallestDivisible(self, n: int) -> int:
        for i in range(1, n + 1):
            if i % n == 0:
                return i