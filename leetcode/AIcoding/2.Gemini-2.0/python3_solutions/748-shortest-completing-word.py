import collections

class Solution:
    def shortestCompletingWord(self, licensePlate: str, words: list[str]) -> str:
        license_counts = collections.Counter(c.lower() for c in licensePlate if c.isalpha())

        shortest_word = None

        for word in words:
            word_counts = collections.Counter(word)

            complete = True
            for char, count in license_counts.items():
                if word_counts[char] < count:
                    complete = False
                    break

            if complete:
                if shortest_word is None or len(word) < len(shortest_word):
                    shortest_word = word

        return shortest_word