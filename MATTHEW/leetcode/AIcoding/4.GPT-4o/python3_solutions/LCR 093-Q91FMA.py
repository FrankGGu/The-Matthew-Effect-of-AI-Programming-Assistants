class Solution:
    def lenLongestFibSubseq(self, A: List[int]) -> int:
        index = {x: i for i, x in enumerate(A)}
        n = len(A)
        dp = {}
        max_length = 0

        for j in range(n):
            for i in range(j):
                k = A[j] - A[i]
                if k in index and index[k] < i:
                    dp[i, j] = dp.get((index[k], i), 2) + 1
                    max_length = max(max_length, dp[i, j])

        return max_length if max_length >= 3 else 0