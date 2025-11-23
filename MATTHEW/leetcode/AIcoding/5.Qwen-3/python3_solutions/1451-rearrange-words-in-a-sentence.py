class Solution:
    def arrangeWords(self, sentence: str) -> str:
        words = sentence.lower().split()
        words.sort(key=lambda x: len(x))
        return ' '.join(words)