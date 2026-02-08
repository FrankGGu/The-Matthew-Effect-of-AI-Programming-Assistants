class Solution:
    def wonderfulSubstrings(self, word: str) -> int:
        count = 0
        freq = {0: 1}
        mask = 0

        for char in word:
            mask ^= 1 << (ord(char) - ord('a'))
            count += freq.get(mask, 0)
            for i in range(10):
                count += freq.get(mask ^ (1 << i), 0)
            freq[mask] = freq.get(mask, 0) + 1

        return count