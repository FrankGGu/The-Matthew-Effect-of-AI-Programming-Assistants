class Solution:
    def mostWordsFound(self, sentences: list[str]) -> int:
        max_words = 0
        for sentence in sentences:
            current_words = len(sentence.split())
            if current_words > max_words:
                max_words = current_words
        return max_words