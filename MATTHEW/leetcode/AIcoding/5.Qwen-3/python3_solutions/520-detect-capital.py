class Solution:
    def detectCapital(self, word: str) -> bool:
        return word == word.capitalize() or word == word.upper()