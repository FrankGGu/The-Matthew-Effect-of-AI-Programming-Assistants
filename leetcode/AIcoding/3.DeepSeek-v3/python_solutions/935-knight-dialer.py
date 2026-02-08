class Solution:
    def knightDialer(self, n: int) -> int:
        MOD = 10**9 + 7
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

        dp_prev = [1] * 10

        for _ in range(n - 1):
            dp_curr = [0] * 10
            for num in range(10):
                for neighbor in moves[num]:
                    dp_curr[num] += dp_prev[neighbor]
                    dp_curr[num] %= MOD
            dp_prev = dp_curr

        return sum(dp_prev) % MOD