class Solution:
    def smallestRangeII(self, A: list[int], K: int) -> int:
        A.sort()
        n = len(A)
        if n == 1:
            return 0

        # The initial range if all elements are modified by +K or all by -K.
        # In both cases, the difference between max and min remains A[n-1] - A[0].
        ans = A[n-1] - A[0]

        # Iterate through all possible split points 'i'.
        # We consider a scenario where elements A[0]...A[i] are increased by K,
        # and elements A[i+1]...A[n-1] are decreased by K.
        # 'i' ranges from 0 to n-2 (inclusive).
        for i in range(n - 1):
            # The minimum value in the modified array B will be the minimum of:
            # 1. The smallest element from the first part (A[0] + K)
            # 2. The smallest element from the second part (A[i+1] - K)
            low = min(A[0] + K, A[i+1] - K)

            # The maximum value in the modified array B will be the maximum of:
            # 1. The largest element from the first part (A[i] + K)
            # 2. The largest element from the second part (A[n-1] - K)
            high = max(A[i] + K, A[n-1] - K)

            # Update the minimum possible range.
            ans = min(ans, high - low)

        return ans