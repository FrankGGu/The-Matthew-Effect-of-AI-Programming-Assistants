from collections import Counter

class Solution:
    def commonChars(self, words: list[str]) -> list[str]:
        if not words:
            return []

        first_word_counts = Counter(words[0])

        for word in words[1:]:
            word_counts = Counter(word)

            new_first_word_counts = {}
            for char in first_word_counts:
                if char in word_counts:
                    new_first_word_counts[char] = min(first_word_counts[char], word_counts[char])

            first_word_counts = new_first_word_counts

        result = []
        for char, count in first_word_counts.items():
            result.extend([char] * count)

        return result