class Solution:
    def equalizeFrequency(self, s: str) -> bool:
        from collections import Counter

        def check(freq):
            counts = Counter(freq.values())
            return len(counts) == 1

        freq = Counter(s)
        for c in freq:
            freq[c] -= 1
            if freq[c] == 0:
                del freq[c]
            if check(freq):
                return True
            freq[c] += 1
        return False