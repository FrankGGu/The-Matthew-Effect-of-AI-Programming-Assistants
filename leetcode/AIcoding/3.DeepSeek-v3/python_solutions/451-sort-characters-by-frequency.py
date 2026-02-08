from collections import defaultdict

class Solution:
    def frequencySort(self, s: str) -> str:
        freq = defaultdict(int)
        for c in s:
            freq[c] += 1

        sorted_chars = sorted(freq.keys(), key=lambda x: -freq[x])

        result = []
        for c in sorted_chars:
            result.append(c * freq[c])

        return ''.join(result)