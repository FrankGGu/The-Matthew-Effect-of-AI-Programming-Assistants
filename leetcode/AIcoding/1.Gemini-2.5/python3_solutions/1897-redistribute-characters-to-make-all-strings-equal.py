import collections

class Solution:
    def makeEqual(self, words: list[str]) -> bool:
        n = len(words)
        if n == 1:
            return True

        char_counts = collections.Counter()
        for word in words:
            char_counts.update(word)

        for count in char_counts.values():
            if count % n != 0:
                return False

        return True