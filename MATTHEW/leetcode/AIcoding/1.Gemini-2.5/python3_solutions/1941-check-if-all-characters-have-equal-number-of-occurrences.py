import collections

class Solution:
    def areOccurrencesEqual(self, s: str) -> bool:
        counts = collections.Counter(s)

        if not counts:
            return True

        first_count = next(iter(counts.values()))

        for count in counts.values():
            if count != first_count:
                return False

        return True