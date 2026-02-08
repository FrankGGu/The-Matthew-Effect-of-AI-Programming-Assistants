class Solution:
    def numWays(self, words: List[str], target: str) -> int:
        MOD = 10**9 + 7
        n = len(words[0])
        m = len(target)
        if m > n:
            return 0

        # Create a frequency table for each character at each position
        freq = [[0] * 26 for _ in range(n)]
        for word in words:
            for i, c in enumerate(word):
                freq[i][ord(c) - ord('a')] += 1

        # Initialize DP table
        dp = [[0] * (n + 1) for _ in range(m + 1)]
        dp[0][0] = 1

        for i in range(m + 1):
            for j in range(n + 1):
                if i == 0 and j == 0:
                    continue
                if i == 0:
                    dp[i][j] = 1
                elif j == 0:
                    dp[i][j] = 0
                else:
                    # Option 1: Do not take the j-th character
                    dp[i][j] = dp[i][j - 1]
                    # Option 2: Take the j-th character if it matches target[i-1]
                    if i <= m and j <= n and i <= j:
                        c = target[i - 1]
                        cnt = freq[j - 1][ord(c) - ord('a')]
                        dp[i][j] += dp[i - 1][j - 1] * cnt
                    dp[i][j] %= MOD

        return dp[m][n]