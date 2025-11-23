class Solution:
    def maxNumberOfBalloons(self, text: str) -> int:
        from collections import Counter

        balloon = Counter("balloon")
        text_count = Counter(text)

        min_count = float('inf')
        for char in balloon:
            if char not in text_count:
                return 0
            min_count = min(min_count, text_count[char] // balloon[char])

        return min_count