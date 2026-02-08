class Solution:
    def shortestCompletingWord(self, licensePlate: str, words: List[str]) -> str:
        from collections import Counter

        count = Counter(c.lower() for c in licensePlate if c.isalpha())
        result = None

        for word in words:
            word_count = Counter(word)
            if all(word_count[c] >= count[c] for c in count):
                if result is None or len(word) < len(result):
                    result = word

        return result