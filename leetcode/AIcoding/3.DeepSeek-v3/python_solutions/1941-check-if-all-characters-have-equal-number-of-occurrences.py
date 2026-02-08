class Solution:
    def areOccurrencesEqual(self, s: str) -> bool:
        freq = {}
        for char in s:
            freq[char] = freq.get(char, 0) + 1
        values = list(freq.values())
        return all(v == values[0] for v in values)