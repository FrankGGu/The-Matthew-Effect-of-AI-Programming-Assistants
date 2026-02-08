from collections import Counter

class Solution:
    def findOriginalArray(self, changed: List[int]) -> List[int]:
        if len(changed) % 2 != 0:
            return []

        count = Counter(changed)
        original = []

        for x in sorted(count):
            if count[x] > count[2 * x]:
                return []
            original.extend([x] * count[x])
            count[2 * x] -= count[x]

        return original