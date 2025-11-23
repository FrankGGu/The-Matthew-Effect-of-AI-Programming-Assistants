class Solution:
    def greatestLetter(self, s: str) -> str:
        seen = set(s)
        for c in reversed(string.ascii_lowercase):
            if c in seen and c.upper() in seen:
                return c.upper()
        return ""