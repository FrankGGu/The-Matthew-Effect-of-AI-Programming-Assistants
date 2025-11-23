from collections import Counter

class Solution:
    def solve(self, s: str) -> str:
        counts = Counter(s)
        odd_chars = [char for char, count in counts.items() if count % 2 != 0]
        if len(odd_chars) > 1:
            return ""

        middle_char = ""
        if len(odd_chars) == 1:
            middle_char = odd_chars[0]
            counts[middle_char] -= 1

        half = ""
        for char in sorted(counts.keys()):
            half += char * (counts[char] // 2)

        return half + middle_char + half[::-1]