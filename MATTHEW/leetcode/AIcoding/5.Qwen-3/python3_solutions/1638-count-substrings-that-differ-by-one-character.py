class Solution:
    def countSubstrings(self, s: str, t: str) -> int:
        def check(i, j):
            diff = 0
            while i < len(s) and j < len(t):
                if s[i] != t[j]:
                    diff += 1
                    if diff > 1:
                        return False
                i += 1
                j += 1
            return diff == 1

        res = 0
        for i in range(len(s)):
            for j in range(len(t)):
                if s[i] != t[j]:
                    res += 1
                    if i + 1 < len(s) and j + 1 < len(t) and s[i+1] == t[j+1]:
                        res += 1
                    if i + 1 < len(s) and j - 1 >= 0 and s[i+1] == t[j-1]:
                        res += 1
                    if i - 1 >= 0 and j + 1 < len(t) and s[i-1] == t[j+1]:
                        res += 1
                    if i - 1 >= 0 and j - 1 >= 0 and s[i-1] == t[j-1]:
                        res += 1
        return res