class Solution:
    def arrangeWords(self, text: str) -> str:
        words = text.split()
        words.sort(key=len)
        result = " ".join(words)
        return result[0].upper() + result[1:].lower()