class Solution:
    def isSubsequence(self, s: str, t: str) -> bool:
        i = 0  # pointer for string s
        j = 0  # pointer for string t

        while i < len(s) and j < len(t):
            if s[i] == t[j]:
                i += 1
            j += 1

        return i == len(s)