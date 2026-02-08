class Solution:
    def smallestRangeII(self, A: List[int], K: int) -> int:
        A.sort()
        n = len(A)
        min_val = A[0]
        max_val = A[-1]
        result = max_val - min_val

        for i in range(n - 1):
            high = max(max_val - K, A[i] + K)
            low = min(min_val + K, A[i + 1] - K)
            result = min(result, high - low)

        return result