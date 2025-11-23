class Solution:
    def countSubstrings(self, s: str, t: str) -> int:
        n = len(s)
        m = len(t)
        ans = 0
        for i in range(n):
            for j in range(m):
                diff = 0
                k = 0
                while i + k < n and j + k < m:
                    if s[i + k] != t[j + k]:
                        diff += 1
                    if diff == 1:
                        ans += 1
                    if diff > 1:
                        break
                    k += 1
        return ans