from collections import Counter

class Solution:
    def makeSmallestPalindrome(self, s: str) -> str:
        counts = Counter(s)
        odd_chars = [char for char, count in counts.items() if count % 2 != 0]
        if len(odd_chars) > 1:
            return ""

        half = ""
        for char in sorted(counts.keys()):
            half += char * (counts[char] // 2)

        middle = ""
        if odd_chars:
            middle = odd_chars[0]

        return half + middle + half[::-1]