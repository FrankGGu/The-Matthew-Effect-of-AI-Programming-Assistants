import math
from bisect import bisect_right

class Solution:
    def getManhattanDistances(self, pieces: list[list[int]], targets: list[list[int]]) -> int:
        MOD = 10**9 + 7
        N = len(pieces)

        PX = [p[0] for p in pieces]
        PY = [p[1] for p in pieces]
        TX = [t[0] for t in targets]
        TY = [t[1] for t in targets]

        if N == 0:
            return 0

        factorial_n_minus_1 = 1
        for i in range(1, N):
            factorial_n_minus_1 = (factorial_n_minus_1 * i) % MOD

        def calculate_sum_abs_diff(arr1: list[int], arr2: list[int]) -> int:
            arr1.sort()
            arr2.sort()

            prefix_sum_arr2 = [0] * (N + 1)
            for i in range(N):
                prefix_sum_arr2[i+1] = prefix_sum_arr2[i] + arr2[i]

            total_sum_for_dim = 0
            for val in arr1:
                k = bisect_right(arr2, val)

                current_val_sum = (2 * k - N) * val - 2 * prefix_sum_arr2[k] + prefix_sum_arr2[N]

                total_sum_for_dim = (total_sum_for_dim + current_val_sum) % MOD

            return (total_sum_for_dim + MOD) % MOD

        sum_x_diffs = calculate_sum_abs_diff(PX, TX)
        sum_y_diffs = calculate_sum_abs_diff(PY, TY)

        total_manhattan_sum = (sum_x_diffs + sum_y_diffs) % MOD

        final_result = (factorial_n_minus_1 * total_manhattan_sum) % MOD

        return final_result