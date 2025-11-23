import collections

class Solution:
    def topKFrequent(self, words: list[str], k: int) -> list[str]:
        counts = collections.Counter(words)

        unique_words = list(counts.keys())

        unique_words.sort(key=lambda word: (-counts[word], word))

        return unique_words[:k]