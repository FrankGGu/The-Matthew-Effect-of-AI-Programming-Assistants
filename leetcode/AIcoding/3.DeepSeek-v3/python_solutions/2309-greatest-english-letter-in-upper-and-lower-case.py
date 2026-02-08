class Solution:
    def greatestLetter(self, s: str) -> str:
        seen = set(s)
        for c in reversed('ABCDEFGHIJKLMNOPQRSTUVWXYZ'):
            if c in seen and c.lower() in seen:
                return c
        return ""