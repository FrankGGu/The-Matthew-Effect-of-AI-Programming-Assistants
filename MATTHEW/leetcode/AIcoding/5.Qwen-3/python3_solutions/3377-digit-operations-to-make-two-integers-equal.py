class Solution:
    def equalizeStrings(self, s: str, t: str) -> bool:
        from collections import Counter

        def countDigits(s):
            return Counter(int(c) for c in s)

        return countDigits(s) == countDigits(t)