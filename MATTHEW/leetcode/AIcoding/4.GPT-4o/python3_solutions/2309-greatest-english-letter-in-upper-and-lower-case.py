class Solution:
    def greatestLetter(self, s: str) -> str:
        lower = set()
        upper = set()

        for char in s:
            if char.islower():
                lower.add(char)
            elif char.isupper():
                upper.add(char.lower())

        for ch in reversed('ABCDEFGHIJKLMNOPQRSTUVWXYZ'):
            if ch.lower() in lower and ch in upper:
                return ch

        return ""