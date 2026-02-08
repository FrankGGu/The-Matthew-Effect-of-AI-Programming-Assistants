import collections

class Solution:
    def maximumLength(self, s: str, k: int) -> int:
        char_counts = collections.Counter(s)

        total_length = 0
        for count in char_counts.values():
            total_length += min(count, k)

        return total_length