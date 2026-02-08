class Solution:
    def removeAlmostEqualCharacters(self, word: str) -> int:
        n = len(word)
        res = 0
        i = 1
        while i < n:
            if abs(ord(word[i]) - ord(word[i-1])) <= 1:
                res += 1
                i += 2
            else:
                i += 1
        return res