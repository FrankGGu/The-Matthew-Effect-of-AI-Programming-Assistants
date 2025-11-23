from collections import Counter

class Solution:
    def minSetSize(self, arr: List[int]) -> int:
        count = Counter(arr)
        frequencies = sorted(count.values(), reverse=True)
        total = len(arr)
        removed = 0
        sets = 0

        for freq in frequencies:
            removed += freq
            sets += 1
            if removed >= total // 2:
                return sets