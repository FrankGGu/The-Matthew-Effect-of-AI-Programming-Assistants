class Solution:
    def minimumPartition(self, s: str) -> int:
        from collections import Counter

        freq = Counter(s)
        unique_chars = len(freq)
        min_partitions = float('inf')

        for char in freq:
            count = freq[char]
            partitions = 0
            for c in freq:
                partitions += (freq[c] + count - 1) // count
            min_partitions = min(min_partitions, partitions)

        return min_partitions if min_partitions != float('inf') else -1