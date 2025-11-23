class Solution:
    def lastRemaining(self, n: int, m: int) -> int:
        if n == 0:
            return -1 

        # This is the iterative solution for the Josephus problem.
        # f(n, m) = (f(n-1, m) + m) % n
        # f(1, m) = 0 (0-indexed)

        # Initialize result for n=1 (0-indexed position)
        res = 0

        # Iterate from i = 2 up to n
        for i in range(2, n + 1):
            res = (res + m) % i

        return res