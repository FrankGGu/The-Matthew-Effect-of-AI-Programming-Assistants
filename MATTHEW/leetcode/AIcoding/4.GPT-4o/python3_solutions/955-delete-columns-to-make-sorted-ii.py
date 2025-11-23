class Solution:
    def minDeletionSize(self, A: List[str]) -> int:
        if not A:
            return 0

        n, m = len(A), len(A[0])
        delete_count = 0
        sorted_cols = set()

        for j in range(m):
            column = [A[i][j] for i in range(n)]
            if j > 0 and column >= [A[i][j-1] for i in range(n)]:
                continue
            if any(column[i] < A[i][j-1] for i in range(n) if i not in sorted_cols):
                delete_count += 1
            else:
                sorted_cols.add(j)

        return delete_count