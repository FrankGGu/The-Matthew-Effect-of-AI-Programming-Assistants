class Solution:
    def equalFrequency(self, word: str) -> bool:
        freq = {}
        for c in word:
            freq[c] = freq.get(c, 0) + 1

        for c in freq:
            freq_copy = freq.copy()
            freq_copy[c] -= 1
            if freq_copy[c] == 0:
                del freq_copy[c]
            if len(set(freq_copy.values())) == 1:
                return True
        return False