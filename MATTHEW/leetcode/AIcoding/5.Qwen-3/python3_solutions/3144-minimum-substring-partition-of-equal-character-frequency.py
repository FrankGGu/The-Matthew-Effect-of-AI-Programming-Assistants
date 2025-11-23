class Solution:
    def minimumSubstringsPartition(self, s: str) -> int:
        from collections import defaultdict

        def is_valid(freq):
            for c in freq:
                if freq[c] > 0 and freq[c] != freq[next(iter(freq))]:
                    return False
            return True

        n = len(s)
        min_partitions = [float('inf')] * (n + 1)
        min_partitions[0] = 0

        for i in range(1, n + 1):
            freq = defaultdict(int)
            for j in range(i - 1, -1, -1):
                freq[s[j]] += 1
                if is_valid(freq):
                    min_partitions[i] = min(min_partitions[i], min_partitions[j] + 1)

        return min_partitions[n]