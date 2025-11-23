class Solution:
    def canBeEqual(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False
        i = j = 0
        while i < len(s) and j < len(t):
            if s[i] == t[j]:
                i += 1
                j += 1
            else:
                if s[i] == ' ':
                    i += 1
                elif t[j] == ' ':
                    j += 1
                else:
                    return False
        return i == len(s) and j == len(t)