class Solution:
    def countSubstrings(self, s: str, t: str) -> int:
        from collections import defaultdict

        m, n = len(s), len(t)
        res = 0

        for i in range(m):
            for j in range(n):
                diff = 0
                k = 0
                while i + k < m and j + k < n:
                    if s[i + k] != t[j + k]:
                        diff += 1
                        if diff > 1:
                            break
                    if diff == 1:
                        res += 1
                    k += 1

        return res