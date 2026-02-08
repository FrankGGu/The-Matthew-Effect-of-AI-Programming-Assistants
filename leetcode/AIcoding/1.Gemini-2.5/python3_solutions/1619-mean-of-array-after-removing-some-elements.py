class Solution:
    def trimMean(self, arr: list[int]) -> float:
        n = len(arr)
        arr.sort()

        elements_to_remove = n // 20  # 5% of n

        trimmed_arr = arr[elements_to_remove : n - elements_to_remove]

        return sum(trimmed_arr) / len(trimmed_arr)