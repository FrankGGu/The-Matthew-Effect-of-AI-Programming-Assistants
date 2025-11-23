class Solution:
    def hasSquare(self, s: str) -> bool:
        n = len(s)
        for i in range(n):
            for j in range(i + 1, n):
                if s[i] == s[j]:
                    return True
        return False