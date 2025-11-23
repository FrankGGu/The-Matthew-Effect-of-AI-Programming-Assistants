class Solution:
    def sortSentence(self, s: str) -> str:
        words = s.split()
        n = len(words)
        result = [None] * n

        for word_with_num in words:
            num = int(word_with_num[-1])
            actual_word = word_with_num[:-1]
            result[num - 1] = actual_word

        return " ".join(result)