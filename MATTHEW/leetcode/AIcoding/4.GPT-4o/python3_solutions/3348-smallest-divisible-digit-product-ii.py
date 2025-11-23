class Solution:
    def smallestDivisible(self, n: int) -> int:
        if n == 1:
            return 1
        for i in range(1, 10**6):
            if all(i % j == 0 for j in range(1, n + 1)):
                return i