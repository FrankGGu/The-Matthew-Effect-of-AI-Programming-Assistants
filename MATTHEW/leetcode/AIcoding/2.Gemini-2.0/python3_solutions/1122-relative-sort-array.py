class Solution:
    def relativeSortArray(self, arr1: List[int], arr2: List[int]) -> List[int]:
        result = []
        remaining = []
        for num in arr2:
            while num in arr1:
                result.append(num)
                arr1.remove(num)
        remaining = sorted(arr1)
        return result + remaining