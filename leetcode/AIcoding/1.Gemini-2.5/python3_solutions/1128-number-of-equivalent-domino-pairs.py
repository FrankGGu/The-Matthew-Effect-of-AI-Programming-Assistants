import collections

class Solution:
    def numEquivDominoPairs(self, dominoes: list[list[int]]) -> int:
        counts = collections.Counter()
        for domino in dominoes:
            # Normalize the domino by sorting its elements
            # This ensures [a, b] and [b, a] become the same key
            key = tuple(sorted(domino))
            counts[key] += 1

        total_pairs = 0
        for count in counts.values():
            # If there are 'n' occurrences of a domino,
            # the number of pairs it forms is n * (n - 1) / 2
            total_pairs += count * (count - 1) // 2

        return total_pairs