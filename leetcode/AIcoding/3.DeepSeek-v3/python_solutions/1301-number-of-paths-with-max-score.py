class Solution:
    def pathsWithMaxScore(self, board: List[str]) -> List[int]:
        n = len(board)
        MOD = 10**9 + 7
        dp = [[[0, 0] for _ in range(n)] for __ in range(n)]
        dp[n-1][n-1] = [0, 1]

        for i in range(n-1, -1, -1):
            for j in range(n-1, -1, -1):
                if board[i][j] == 'X':
                    continue
                if i == n-1 and j == n-1:
                    continue
                max_score = 0
                count = 0
                for di, dj in [(1, 0), (0, 1), (1, 1)]:
                    ni, nj = i + di, j + dj
                    if ni < n and nj < n:
                        if dp[ni][nj][1] > 0:
                            if dp[ni][nj][0] > max_score:
                                max_score = dp[ni][nj][0]
                                count = dp[ni][nj][1]
                            elif dp[ni][nj][0] == max_score:
                                count += dp[ni][nj][1]
                if count > 0:
                    current_val = 0 if board[i][j] == 'S' or board[i][j] == 'E' else int(board[i][j])
                    dp[i][j] = [max_score + current_val, count % MOD]

        return [dp[0][0][0], dp[0][0][1] % MOD] if dp[0][0][1] > 0 else [0, 0]