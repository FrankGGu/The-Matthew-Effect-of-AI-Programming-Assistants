class Solution:
    def getLongestSubsequence(self, n: int, s: str, k: int) -> str:
        from collections import defaultdict

        dp = [0] * (k + 1)
        prev = [-1] * (k + 1)

        for i in range(n):
            c = ord(s[i]) - ord('a')
            for j in range(k, -1, -1):
                if j != c:
                    if dp[j] + 1 > dp[c]:
                        dp[c] = dp[j] + 1
                        prev[c] = j

        res = []
        current = max(range(k + 1), key=lambda x: dp[x])
        while current != -1:
            res.append(chr(current + ord('a')))
            current = prev[current]

        return ''.join(res[::-1])