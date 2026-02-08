class Solution:
    def longestSemiRepetitiveSubstring(self, s: str) -> int:
        max_len = 1
        n = len(s)
        for i in range(n):
            cnt = 0
            for j in range(i + 1, n):
                if s[j] == s[j - 1]:
                    cnt += 1
                    if cnt > 1:
                        break
                max_len = max(max_len, j - i + 1)
        return max_len