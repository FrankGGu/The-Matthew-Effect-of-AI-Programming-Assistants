class Solution:
    def lenLongestFibSubsequence(self, A: list[int]) -> int:
        n = len(A)
        val_to_idx = {x: i for i, x in enumerate(A)}

        dp = {}
        max_len = 0

        for i in range(n):
            for j in range(i):
                target = A[i] - A[j]

                if target < A[j] and target in val_to_idx:
                    k = val_to_idx[target]

                    current_len = dp.get((k, j), 2) + 1

                    dp[(j, i)] = current_len
                    max_len = max(max_len, current_len)

        return max_len