class Solution:
    def longestSemiRepetitiveSubstring(self, s: str) -> int:
        n = len(s)
        max_len = 0
        for i in range(n):
            for j in range(i, n):
                sub = s[i:j+1]
                count = 0
                for k in range(len(sub) - 1):
                    if sub[k] == sub[k+1]:
                        count += 1
                if count <= 1:
                    max_len = max(max_len, len(sub))
        return max_len