class Solution:
    def pathsWithMaxScore(self, board: List[List[str]]) -> List[int]:
        n = len(board)
        dp = [[0] * n for _ in range(n)]
        mod = 10 ** 9 + 7

        for i in range(n - 1, -1, -1):
            for j in range(n - 1, -1, -1):
                if board[i][j] == 'X':
                    dp[i][j] = -1
                else:
                    score = int(board[i][j]) if board[i][j] != 'E' and board[i][j] != 'S' else 0
                    if i == n - 1 and j == n - 1:
                        dp[i][j] = score
                    else:
                        if i + 1 < n and dp[i + 1][j] != -1:
                            dp[i][j] = max(dp[i][j], score + dp[i + 1][j])
                        if j + 1 < n and dp[i][j + 1] != -1:
                            dp[i][j] = max(dp[i][j], score + dp[i][j + 1])

        if dp[0][0] == -1:
            return [0, 0]

        paths = 0
        max_score = dp[0][0]
        if max_score == 0:
            return [max_score, 1]

        def count_paths(i, j):
            if i == n - 1 and j == n - 1:
                return 1
            count = 0
            if i + 1 < n and dp[i + 1][j] == max_score - int(board[i][j]):
                count += count_paths(i + 1, j)
            if j + 1 < n and dp[i][j + 1] == max_score - int(board[i][j]):
                count += count_paths(i, j + 1)
            return count

        paths = count_paths(0, 0) % mod

        return [max_score, paths]