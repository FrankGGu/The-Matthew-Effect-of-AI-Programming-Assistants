class Solution:
    def solve(self, board):
        m, n = len(board), len(board[0])
        total_sum = 0
        for i in range(m):
            for j in range(n):
                total_sum += board[i][j]

        max_reduction = 0
        for r1 in range(m):
            for c1 in range(n):
                for r2 in range(m):
                    for c2 in range(n):
                        if (r1 == r2 and c1 == c2):
                            continue
                        for r3 in range(m):
                            for c3 in range(n):
                                if (r3 == r1 and c3 == c1) or (r3 == r2 and c3 == c2):
                                    continue

                                reduction = 0
                                rows = set()
                                cols = set()
                                rows.add(r1)
                                rows.add(r2)
                                rows.add(r3)
                                cols.add(c1)
                                cols.add(c2)
                                cols.add(c3)

                                for r in rows:
                                    for c in range(n):
                                        if c != c1 and c != c2 and c != c3:
                                            reduction += board[r][c]
                                for c in cols:
                                    for r in range(m):
                                        if r != r1 and r != r2 and r != r3:
                                            reduction += board[r][c]
                                max_reduction = max(max_reduction, reduction)
        return total_sum - max_reduction

    def maximumValueSum(self, board: list[list[int]]) -> int:
        return self.solve(board)