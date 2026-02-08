class Solution:
    def matrixSumQueries(self, n: int, queries: List[List[int]]) -> List[int]:
        row_sum = [0] * n
        col_sum = [0] * n
        total_sum = 0
        result = []

        for t, i, val in queries:
            if t == 0:
                if row_sum[i] == 0:
                    total_sum += sum(col_sum)
                row_sum[i] += val
                total_sum += val
            else:
                if col_sum[i] == 0:
                    total_sum += sum(row_sum)
                col_sum[i] += val
                total_sum += val
            result.append(total_sum)

        return result