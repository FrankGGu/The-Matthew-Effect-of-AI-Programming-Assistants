class Solution:
    def knightDialer(self, n: int) -> int:
        mod = 10**9 + 7
        moves = {
            0: [4, 6],
            1: [6, 8],
            2: [7, 9],
            3: [4, 8],
            4: [0, 3, 9],
            5: [],
            6: [0, 1, 7],
            7: [2, 6],
            8: [1, 3],
            9: [2, 4]
        }

        dp = [[0] * 10 for _ in range(n)]

        for i in range(10):
            dp[0][i] = 1

        for i in range(1, n):
            for j in range(10):
                for move in moves[j]:
                    dp[i][move] = (dp[i][move] + dp[i - 1][j]) % mod

        return sum(dp[n - 1]) % mod