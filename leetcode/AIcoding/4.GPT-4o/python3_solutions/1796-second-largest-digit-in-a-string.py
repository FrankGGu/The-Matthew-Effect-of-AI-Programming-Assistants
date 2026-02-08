class Solution:
    def secondHighest(self, s: str) -> int:
        digits = set(int(c) for c in s if c.isdigit())
        if len(digits) < 2:
            return -1
        return sorted(digits)[-2]