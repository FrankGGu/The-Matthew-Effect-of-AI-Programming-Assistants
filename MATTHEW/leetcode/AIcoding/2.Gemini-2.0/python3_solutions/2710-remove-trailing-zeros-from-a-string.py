class Solution:
    def removeTrailingZeros(self, s: str) -> str:
        i = len(s) - 1
        while i >= 0 and s[i] == '0':
            i -= 1
        return s[:i+1]