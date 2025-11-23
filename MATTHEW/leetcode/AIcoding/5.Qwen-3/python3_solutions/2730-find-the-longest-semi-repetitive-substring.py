class Solution:
    def longestSemiRepetitiveSubstring(self, s: str) -> int:
        n = len(s)
        max_len = 0
        for i in range(n):
            count = 0
            for j in range(i, n):
                if j > 0 and s[j] == s[j-1]:
                    count += 1
                if count <= 1:
                    max_len = max(max_len, j - i + 1)
                else:
                    break
        return max_len