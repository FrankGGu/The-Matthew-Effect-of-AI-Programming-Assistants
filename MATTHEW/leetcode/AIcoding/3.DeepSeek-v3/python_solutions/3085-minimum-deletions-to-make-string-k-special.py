class Solution:
    def minimumDeletions(self, word: str, k: int) -> int:
        freq = {}
        for c in word:
            freq[c] = freq.get(c, 0) + 1

        counts = sorted(freq.values())
        min_deletions = float('inf')

        for i in range(len(counts)):
            target = counts[i]
            deletions = 0
            for j in range(len(counts)):
                if j < i:
                    deletions += counts[j]
                else:
                    if counts[j] > target + k:
                        deletions += counts[j] - (target + k)
            min_deletions = min(min_deletions, deletions)

        return min_deletions