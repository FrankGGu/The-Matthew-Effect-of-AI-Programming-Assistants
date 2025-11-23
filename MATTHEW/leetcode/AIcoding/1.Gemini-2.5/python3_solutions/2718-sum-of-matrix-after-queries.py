class Solution:
    def matrixSumQueries(self, n: int, queries: list[list[int]]) -> int:
        total_sum = 0

        rows_covered = set()
        cols_covered = set()

        num_rows_covered = 0
        num_cols_covered = 0

        for query_type, index, val in reversed(queries):
            if query_type == 0:  # Row query
                if index not in rows_covered:
                    total_sum += val * (n - num_cols_covered)
                    rows_covered.add(index)
                    num_rows_covered += 1

                    if num_rows_covered == n:
                        break
            else:  # Column query
                if index not in cols_covered:
                    total_sum += val * (n - num_rows_covered)
                    cols_covered.add(index)
                    num_cols_covered += 1

                    if num_cols_covered == n:
                        break

        return total_sum