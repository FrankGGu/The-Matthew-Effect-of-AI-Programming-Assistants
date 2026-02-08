class Solution:
    def maxRotateFunction(self, A: List[int]) -> int:
        n = len(A)
        total_sum = sum(A)
        current_value = sum(i * A[i] for i in range(n))
        max_value = current_value

        for i in range(1, n):
            current_value = current_value + total_sum - n * A[n - i]
            max_value = max(max_value, current_value)

        return max_value