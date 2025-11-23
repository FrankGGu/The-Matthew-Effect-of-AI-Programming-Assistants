from collections import Counter

class Solution:
    def relativeSortArray(self, arr1: list[int], arr2: list[int]) -> list[int]:
        counts = Counter(arr1)
        result = []

        for num in arr2:
            result.extend([num] * counts[num])
            counts[num] = 0

        for num in range(1001):  # Elements are between 0 and 1000
            if counts[num] > 0:
                result.extend([num] * counts[num])

        return result