import collections

class Solution:
    def uncommonFromSentences(self, s1: str, s2: str) -> list[str]:
        all_words = (s1 + " " + s2).split()

        word_counts = collections.Counter(all_words)

        uncommon = []
        for word, count in word_counts.items():
            if count == 1:
                uncommon.append(word)

        return uncommon