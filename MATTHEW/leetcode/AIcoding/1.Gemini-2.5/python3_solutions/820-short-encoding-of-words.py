class Solution:
    def minimumLengthEncoding(self, words: List[str]) -> int:
        good_words = set(words)

        for word in words:
            for i in range(1, len(word)):
                suffix = word[i:]
                if suffix in good_words:
                    good_words.remove(suffix)

        total_length = 0
        for word in good_words:
            total_length += len(word) + 1

        return total_length