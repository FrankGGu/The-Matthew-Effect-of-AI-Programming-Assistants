class Solution:
    def trimMean(self, arr: list[int]) -> float:
        arr.sort()
        n = len(arr)
        remove_count = int(n * 0.05)
        trimmed_arr = arr[remove_count:n - remove_count]
        return sum(trimmed_arr) / len(trimmed_arr)