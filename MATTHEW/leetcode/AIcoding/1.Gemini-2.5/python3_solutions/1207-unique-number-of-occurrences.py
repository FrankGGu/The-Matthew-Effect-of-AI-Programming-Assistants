import collections

class Solution:
    def uniqueOccurrences(self, arr: list[int]) -> bool:
        counts = collections.Counter(arr)

        occurrence_values = list(counts.values())

        return len(occurrence_values) == len(set(occurrence_values))