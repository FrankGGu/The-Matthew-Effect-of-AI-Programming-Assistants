class Solution:
    def wonderfulSubstrings(self, word: str) -> int:
        count = 0
        prefix_xor = 0
        freq = {0: 1}
        for char in word:
            prefix_xor ^= (1 << (ord(char) - ord('a')))
            count += freq.get(prefix_xor, 0)
            for i in range(10):
                count += freq.get(prefix_xor ^ (1 << i), 0)
            freq[prefix_xor] = freq.get(prefix_xor, 0) + 1
        return count