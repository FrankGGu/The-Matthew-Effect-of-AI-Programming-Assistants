class Solution:
    def pathsWithMaxScore(self, board: List[str]) -> List[int]:
        n = len(board)
        dp = [[(0, 0)] * n for _ in range(n)]
        dp[n - 1][n - 1] = (0, 1)
        mod = 10**9 + 7

        for i in range(n - 1, -1, -1):
            for j in range(n - 1, -1, -1):
                if board[i][j] == 'X':
                    continue
                if i == n - 1 and j == n - 1:
                    continue

                max_score = -1
                total_paths = 0

                if i + 1 < n and dp[i + 1][j][1] > 0:
                    score, paths = dp[i + 1][j]
                    if score > max_score:
                        max_score = score
                        total_paths = paths
                    elif score == max_score:
                        total_paths = (total_paths + paths) % mod

                if j + 1 < n and dp[i][j + 1][1] > 0:
                    score, paths = dp[i][j + 1]
                    if score > max_score:
                        max_score = score
                        total_paths = paths
                    elif score == max_score:
                        total_paths = (total_paths + paths) % mod

                if i + 1 < n and j + 1 < n and dp[i + 1][j + 1][1] > 0:
                    score, paths = dp[i + 1][j + 1]
                    if score > max_score:
                        max_score = score
                        total_paths = paths
                    elif score == max_score:
                        total_paths = (total_paths + paths) % mod

                if max_score != -1:
                    val = int(board[i][j]) if board[i][j] != 'S' else 0
                    dp[i][j] = (max_score + val, total_paths)

        if dp[0][0][1] == 0:
            return [0, 0]
        else:
            return [dp[0][0][0], dp[0][0][1]]