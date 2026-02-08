class Solution:
    def commonElements(self, arr1: list[int], arr2: list[int]) -> list[int]:
        set1 = set(arr1)
        set2 = set(arr2)
        return sorted(list(set1.intersection(set2)))