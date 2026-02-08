class Solution:
    def uniquePaths(self, m: int, n: int) -> int:
        # The problem can be solved using combinatorics.
        # To reach the bottom-right corner from the top-left corner,
        # the robot must make exactly (m-1) down moves and (n-1) right moves.
        # The total number of moves will be (m-1) + (n-1) = m + n - 2.
        # This is equivalent to finding the number of ways to choose (m-1) down moves
        # (or (n-1) right moves) from a total of (m + n - 2) moves.
        # This is given by the binomial coefficient C(N, K), where N = m + n - 2
        # and K = m - 1 (or n - 1).

        N = m + n - 2
        K = min(m - 1, n - 1) # Choose the smaller K to minimize calculations

        res = 1
        for i in range(K):
            res = res * (N - i) // (i + 1)

        return res