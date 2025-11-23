class Solution:
    def numWays(self, words: List[str], target: str) -> int:
        MOD = 10**9 + 7
        m = len(target)
        n = len(words[0])
        freq = [[0] * 26 for _ in range(n)]
        for word in words:
            for i, c in enumerate(word):
                freq[i][ord(c) - ord('a')] += 1

        dp = [0] * (m + 1)
        dp[0] = 1

        for i in range(n):
            new_dp = dp[:]
            for j in range(m):
                new_dp[j+1] = (new_dp[j+1] + dp[j] * freq[i][ord(target[j]) - ord('a')]) % MOD
            dp = new_dp

        return dp[m]