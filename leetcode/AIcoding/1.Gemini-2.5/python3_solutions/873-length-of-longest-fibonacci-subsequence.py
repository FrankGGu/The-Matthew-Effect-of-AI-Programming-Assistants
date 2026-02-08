class Solution:
    def lenLongestFibSubseq(self, arr: list[int]) -> int:
        n = len(arr)
        num_to_idx = {num: i for i, num in enumerate(arr)}

        dp = {}
        max_len = 0

        for j in range(n):
            for i in range(j):
                prev_num = arr[j] - arr[i]

                if prev_num < arr[i] and prev_num in num_to_idx:
                    k = num_to_idx[prev_num]
                    dp[(i, j)] = dp.get((k, i), 2) + 1
                else:
                    dp[(i, j)] = 2

                if dp[(i, j)] > 2:
                    max_len = max(max_len, dp[(i, j)])

        return max_len