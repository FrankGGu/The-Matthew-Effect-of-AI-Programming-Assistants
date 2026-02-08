class Solution:
    def trimMean(self, arr: List[int]) -> float:
        arr.sort()
        n = len(arr)
        remove = n // 20
        trimmed = arr[remove : n - remove]
        return sum(trimmed) / len(trimmed)