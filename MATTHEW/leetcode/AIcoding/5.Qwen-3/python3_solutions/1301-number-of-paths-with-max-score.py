class Solution:
    def pathWithMaxScore(self, board: List[str]) -> List[int]:
        from collections import defaultdict

        MOD = 10**9 + 7

        rows, cols = len(board), len(board[0])
        dp = [[defaultdict(int) for _ in range(cols)] for _ in range(rows)]

        dp[rows-1][cols-1][0] = 0
        dp[rows-1][cols-1][1] = 1

        for i in range(rows-1, -1, -1):
            for j in range(cols-1, -1, -1):
                if board[i][j] == 'X':
                    continue
                if i == rows-1 and j == cols-1:
                    continue
                max_score = -1
                count = 0
                for dx, dy in [(0,1), (1,0), (1,1)]:
                    ni, nj = i + dx, j + dy
                    if 0 <= ni < rows and 0 <= nj < cols:
                        for score in dp[ni][nj]:
                            if score > max_score:
                                max_score = score
                                count = dp[ni][nj][score]
                            elif score == max_score:
                                count += dp[ni][nj][score]
                if max_score != -1:
                    current_score = int(board[i][j]) if board[i][j] != 'S' and board[i][j] != 'E' else 0
                    dp[i][j][max_score + current_score] = count % MOD

        return [dp[0][0][max(dp[0][0].keys())], dp[0][0].get(max(dp[0][0].keys()), 0)]