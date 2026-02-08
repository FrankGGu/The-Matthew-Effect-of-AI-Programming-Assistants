class Solution:
    def minimumLengthEncoding(self, words: list[str]) -> int:
        unique_words = set(words)

        for word in words:
            for i in range(1, len(word)):
                suffix = word[i:]
                if suffix in unique_words:
                    unique_words.discard(suffix)

        total_length = 0
        for word in unique_words:
            total_length += len(word) + 1

        return total_length