class Solution:
    def sumOddLengthSubarrays(self, arr: list[int]) -> int:
        total_sum = 0
        n = len(arr)

        for i in range(n):
            current_subarray_sum = 0
            for j in range(i, n):
                current_subarray_sum += arr[j]
                # Check if the length of the current subarray (arr[i...j]) is odd
                if (j - i + 1) % 2 == 1:
                    total_sum += current_subarray_sum

        return total_sum