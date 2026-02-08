class Solution:
    def matrixSumQueries(self, n: int, queries: List[List[int]]) -> int:
        matrix = [[0] * n for _ in range(n)]
        total_sum = 0
        rows_set = set()
        cols_set = set()

        for type, index, val in reversed(queries):
            if type == 0:
                if index not in rows_set:
                    for j in range(n):
                        if j not in cols_set:
                            total_sum += val
                            matrix[index][j] = val
                    rows_set.add(index)
            else:
                if index not in cols_set:
                    for i in range(n):
                        if i not in rows_set:
                            total_sum += val
                            matrix[i][index] = val
                    cols_set.add(index)

        return total_sum