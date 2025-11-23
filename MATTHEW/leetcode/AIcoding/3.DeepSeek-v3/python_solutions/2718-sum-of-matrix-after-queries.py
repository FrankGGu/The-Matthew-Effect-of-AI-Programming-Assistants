class Solution:
    def matrixSumQueries(self, n: int, queries: List[List[int]]) -> int:
        row_seen = set()
        col_seen = set()
        total = 0
        # Process queries in reverse to account for overwrites
        for query in reversed(queries):
            typ, index, val = query
            if typ == 0:  # row operation
                if index not in row_seen:
                    row_seen.add(index)
                    remaining_cols = n - len(col_seen)
                    total += remaining_cols * val
            else:  # col operation
                if index not in col_seen:
                    col_seen.add(index)
                    remaining_rows = n - len(row_seen)
                    total += remaining_rows * val
        return total