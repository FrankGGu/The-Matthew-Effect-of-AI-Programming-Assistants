import collections

class Solution:
    def runeReserve(self, runes: list[int]) -> int:
        counts = collections.Counter(runes)

        total_reserves = 0

        sorted_unique_runes = sorted(counts.keys())

        for x in sorted_unique_runes:
            if (x + 1) in counts and (x + 2) in counts:
                total_reserves += counts[x] * counts[x + 1] * counts[x + 2]

        return total_reserves