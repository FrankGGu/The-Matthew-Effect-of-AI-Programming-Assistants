class Solution:
    def findSubstringInWraproundString(self, p: str) -> int:
        if not p:
            return 0

        dp = [0] * 26
        max_len = 0

        for i, char in enumerate(p):
            curr = ord(char) - ord('a')
            if i > 0:
                prev = ord(p[i - 1]) - ord('a')
                if (curr - prev) % 26 == 1:
                    max_len += 1
                else:
                    max_len = 1
            else:
                max_len = 1

            dp[curr] = max(dp[curr], max_len)

        return sum(dp)