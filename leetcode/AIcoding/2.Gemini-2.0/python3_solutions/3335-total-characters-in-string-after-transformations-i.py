class Solution:
    def totalCharacters(self, words: list[str]) -> int:
        res = 0
        for word in words:
            res += len(word)
        return res