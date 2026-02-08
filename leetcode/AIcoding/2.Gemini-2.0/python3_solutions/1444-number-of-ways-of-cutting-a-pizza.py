class Solution:
    def ways(self, pizza: List[str], k: int) -> int:
        m, n = len(pizza), len(pizza[0])
        apples = [[0] * (n + 1) for _ in range(m + 1)]
        for i in range(m - 1, -1, -1):
            for j in range(n - 1, -1, -1):
                apples[i][j] = apples[i + 1][j] + apples[i][j + 1] - apples[i + 1][j + 1] + (pizza[i][j] == 'A')

        dp = [[[0] * n for _ in range(m)] for _ in range(k)]

        def solve(row, col, cuts):
            if cuts == k - 1:
                return 1 if apples[row][col] > 0 else 0

            if dp[cuts][row][col] != 0:
                return dp[cuts][row][col]

            ans = 0
            for i in range(row + 1, m):
                if apples[row][col] - apples[i][col] > 0:
                    ans = (ans + solve(i, col, cuts + 1)) % (10**9 + 7)

            for j in range(col + 1, n):
                if apples[row][col] - apples[row][j] > 0:
                    ans = (ans + solve(row, j, cuts + 1)) % (10**9 + 7)

            dp[cuts][row][col] = ans
            return ans

        return solve(0, 0, 0)