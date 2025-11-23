class Solution:
    def containsPattern(self, s: str, m: int, k: int) -> bool:
        n = len(s)
        for i in range(n - m * k + 1):
            if s[i:i + m] * k == s[i:i + m * k]:
                return True
        return False