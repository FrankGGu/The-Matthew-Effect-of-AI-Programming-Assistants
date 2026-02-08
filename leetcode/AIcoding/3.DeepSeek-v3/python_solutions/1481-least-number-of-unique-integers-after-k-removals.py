import collections

class Solution:
    def findLeastNumOfUniqueInts(self, arr: List[int], k: int) -> int:
        freq = collections.Counter(arr)
        sorted_freq = sorted(freq.values())
        removed = 0
        for i, count in enumerate(sorted_freq):
            if k >= count:
                k -= count
                removed += 1
            else:
                break
        return len(sorted_freq) - removed