class Solution:
    def totalNQueens(self, n: int) -> int:
        self.count = 0
        self.n = n
        self.cols = set()
        self.diag1 = set()  # (row - col)
        self.diag2 = set()  # (row + col)

        def backtrack(row):
            if row == self.n:
                self.count += 1
                return

            for col in range(self.n):
                if col in self.cols or (row - col) in self.diag1 or (row + col) in self.diag2:
                    continue

                self.cols.add(col)
                self.diag1.add(row - col)
                self.diag2.add(row + col)

                backtrack(row + 1)

                self.cols.remove(col)
                self.diag1.remove(row - col)
                self.diag2.remove(row + col)

        backtrack(0)
        return self.count