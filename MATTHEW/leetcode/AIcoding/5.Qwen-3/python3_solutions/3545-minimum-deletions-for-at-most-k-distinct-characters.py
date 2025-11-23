class Solution:
    def minDeletions(self, s: str, k: int) -> int:
        from collections import Counter

        counts = Counter(s)
        freq = [count for count in counts.values()]
        freq.sort(reverse=True)

        deletions = 0

        for i in range(1, len(freq)):
            if freq[i] >= freq[i - 1]:
                needed = freq[i - 1] - (freq[i] - freq[i - 1])
                if needed < 0:
                    needed = 0
                deletions += (freq[i] - needed)
                freq[i] = needed

        return deletions