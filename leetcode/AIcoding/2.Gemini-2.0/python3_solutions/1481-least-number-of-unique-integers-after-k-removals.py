from collections import Counter

class Solution:
    def findLeastNumOfUniqueInts(self, arr: list[int], k: int) -> int:
        count = Counter(arr)
        freq = sorted(count.values())

        removed = 0
        for f in freq:
            if k >= f:
                k -= f
                removed += 1
            else:
                break

        return len(freq) - removed