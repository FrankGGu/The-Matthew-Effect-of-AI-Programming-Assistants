class Solution:
    def minimumDistance(self, word: str) -> int:
        from itertools import product

        n = len(word)
        dp = [[float('inf')] * 26 for _ in range(26)]
        for i in range(26):
            dp[i][i] = 0

        def dist(c1, c2):
            r1, c1 = divmod(c1, 6)
            r2, c2 = divmod(c2, 6)
            return abs(r1 - r2) + abs(c1 - c2)

        for c1 in range(26):
            for c2 in range(26):
                if c1 != c2:
                    dp[c1][c2] = dist(c1, c2)

        dp_curr = [[float('inf')] * 26 for _ in range(26)]
        dp_curr[0][0] = 0

        for i in range(n):
            c = ord(word[i]) - ord('A')
            for f1, f2 in product(range(26), repeat=2):
                dp_curr[c][f1] = min(dp_curr[c][f1], dp[f1][c] + dp_curr[f2][f1])
                dp_curr[f1][c] = min(dp_curr[f1][c], dp[f2][c] + dp_curr[f1][f2])
            dp_curr[c][c] = min(dp_curr[c][c], dp_curr[f1][f2] + 0)
            dp = dp_curr
            dp_curr = [[float('inf')] * 26 for _ in range(26)]

        return min(map(min, dp))