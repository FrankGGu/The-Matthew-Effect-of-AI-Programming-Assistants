class Solution:
    def trimMean(self, arr: List[int]) -> float:
        arr.sort()
        n = len(arr)
        trim_size = n // 20
        return sum(arr[trim_size:n-trim_size]) / (n - 2 * trim_size)