class Solution:
    def countKFrequency(self, s: str, k: int) -> int:
        from collections import Counter

        count = 0
        n = len(s)

        for i in range(n):
            freq = Counter()
            for j in range(i, n):
                freq[s[j]] += 1
                if len(freq) == k and all(v == 1 for v in freq.values()):
                    count += 1

        return count