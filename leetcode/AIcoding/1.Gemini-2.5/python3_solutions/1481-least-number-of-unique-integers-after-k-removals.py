import collections

class Solution:
    def findLeastNumOfUniqueInts(self, arr: list[int], k: int) -> int:
        counts = collections.Counter(arr)

        frequencies = sorted(counts.values())

        unique_count = len(frequencies)

        for freq in frequencies:
            if k >= freq:
                k -= freq
                unique_count -= 1
            else:
                break

        return unique_count