class Solution:
    def variableLengthSubarrays(self, arr: List[int]) -> int:
        n = len(arr)
        total_sum = 0
        for length in range(1, n + 1):
            for start in range(n - length + 1):
                total_sum += sum(arr[start:start + length])
        return total_sum