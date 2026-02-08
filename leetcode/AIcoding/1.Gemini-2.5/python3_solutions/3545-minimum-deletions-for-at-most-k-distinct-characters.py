import collections

class Solution:
    def minimumDeletions(self, s: str, k: int) -> int:
        counts = collections.Counter(s)

        if len(counts) <= k:
            return 0

        frequencies = list(counts.values())
        frequencies.sort()

        deletions = 0

        chars_to_remove_count = len(frequencies) - k

        for i in range(chars_to_remove_count):
            deletions += frequencies[i]

        return deletions