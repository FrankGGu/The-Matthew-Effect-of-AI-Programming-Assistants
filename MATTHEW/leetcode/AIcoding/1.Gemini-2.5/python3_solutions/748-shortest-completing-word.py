import collections

class Solution:
    def shortestCompletingWord(self, licensePlate: str, words: list[str]) -> str:

        lp_chars = []
        for char in licensePlate:
            if 'a' <= char.lower() <= 'z':
                lp_chars.append(char.lower())

        lp_counts = collections.Counter(lp_chars)

        shortest_word = ""
        min_length = float('inf')

        for word in words:
            word_counts = collections.Counter(word)

            completes = True
            for char, count in lp_counts.items():
                if word_counts[char] < count:
                    completes = False
                    break

            if completes:
                if len(word) < min_length:
                    min_length = len(word)
                    shortest_word = word

        return shortest_word