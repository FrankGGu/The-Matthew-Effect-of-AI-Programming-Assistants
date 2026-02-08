class Solution:
    def longestPalindrome(self, s: str, k: int) -> int:
        n = len(s)
        dp = [[0] * n for _ in range(n)]
        for i in range(n-1, -1, -1):
            dp[i][i] = 1
            for j in range(i+1, n):
                if s[i] == s[j]:
                    dp[i][j] = dp[i+1][j-1] + 2
                else:
                    dp[i][j] = max(dp[i+1][j], dp[i][j-1])

        def dfs(l, r, k_left):
            if l >= r:
                return 0
            if s[l] == s[r]:
                return dfs(l+1, r-1, k_left) + 2
            else:
                if k_left > 0:
                    return max(dfs(l+1, r, k_left-1) + 2, dfs(l+1, r, k_left), dfs(l, r-1, k_left))
                else:
                    return max(dfs(l+1, r, k_left), dfs(l, r-1, k_left))

        return dfs(0, n-1, k)