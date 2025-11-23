class Solution:
    def sumOddLengthSubarrays(self, arr: List[int]) -> int:
        n = len(arr)
        total_sum = 0

        for i in range(n):
            total_sum += arr[i] * ((i + 1) * (n - i + 1) + 1) // 2

        return total_sum