class Solution:
    def longestNiceSubstring(self, s: str) -> str:
        def is_nice(sub):
            chars = set(sub)
            for c in chars:
                if c.lower() not in chars or c.upper() not in chars:
                    return False
            return True

        max_sub = ""
        n = len(s)
        for i in range(n):
            for j in range(i + 1, n + 1):
                sub = s[i:j]
                if is_nice(sub) and len(sub) > len(max_sub):
                    max_sub = sub
        return max_sub