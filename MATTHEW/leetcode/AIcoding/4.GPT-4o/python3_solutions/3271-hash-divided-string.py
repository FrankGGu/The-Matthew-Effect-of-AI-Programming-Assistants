class Solution:
    def hashDividedString(self, s: str) -> str:
        return s if len(s) % 2 == 0 else s + '0'