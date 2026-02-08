class Solution:
    def minimumOperationsToMakeKPeriodic(self, word: str, k: int) -> int:
        from collections import defaultdict

        n = len(word)
        freq = defaultdict(int)
        max_freq = 0

        for i in range(0, n, k):
            segment = word[i:i+k]
            freq[segment] += 1
            if freq[segment] > max_freq:
                max_freq = freq[segment]

        return (n // k) - max_freq