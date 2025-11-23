from collections import Counter

class Solution:
    def findOriginalArray(self, changed: list[int]) -> list[int]:
        if len(changed) % 2 != 0:
            return []

        count = Counter(changed)
        original = []

        for num in sorted(changed):
            if count[num] > 0:
                if count[num * 2] > 0:
                    original.append(num)
                    count[num] -= 1
                    count[num * 2] -= 1
                else:
                    return []

        return original