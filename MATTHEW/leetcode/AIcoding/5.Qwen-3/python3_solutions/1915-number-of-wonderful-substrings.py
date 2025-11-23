class Solution:
    def wonderfulSubstrings(self, word: str) -> int:
        count = [0] * 1024
        count[0] = 1
        result = 0
        for c in word:
            mask = 1 << (ord(c) - ord('a'))
            for i in range(1024):
                result += count[i]
            count[mask] += 1
        return result