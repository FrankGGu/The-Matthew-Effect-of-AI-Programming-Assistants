class Solution:
    def minimumDistance(self, word: str) -> int:
        def distance(a, b):
            if a == -1 or b == -1:
                return 0
            x1, y1 = divmod(a, 6)
            x2, y2 = divmod(b, 6)
            return abs(x1 - x2) + abs(y1 - y2)

        n = len(word)
        dp = [[[float('inf')] * 26 for _ in range(26)] for _ in range(n + 1)]
        dp[0][-1][-1] = 0

        for i in range(n):
            c = ord(word[i]) - ord('A')
            for a in range(-1, 26):
                for b in range(-1, 26):
                    if dp[i][a][b] == float('inf'):
                        continue
                    # Move finger 1 to current character
                    new_a = c
                    cost = distance(a, new_a)
                    if dp[i + 1][new_a][b] > dp[i][a][b] + cost:
                        dp[i + 1][new_a][b] = dp[i][a][b] + cost
                    # Move finger 2 to current character
                    new_b = c
                    cost = distance(b, new_b)
                    if dp[i + 1][a][new_b] > dp[i][a][b] + cost:
                        dp[i + 1][a][new_b] = dp[i][a][b] + cost

        min_dist = float('inf')
        for a in range(26):
            for b in range(26):
                if dp[n][a][b] < min_dist:
                    min_dist = dp[n][a][b]
        return min_dist