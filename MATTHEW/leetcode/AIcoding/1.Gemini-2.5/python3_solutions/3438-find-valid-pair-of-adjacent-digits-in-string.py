class Solution:
    def findValidPair(self, s: str) -> bool:
        n = len(s)
        if n < 2:
            return False

        for i in range(n - 1):
            if s[i].isdigit() and s[i+1].isdigit() and s[i] == s[i+1]:
                return True
        return False