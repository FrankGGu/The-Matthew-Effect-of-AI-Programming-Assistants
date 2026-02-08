class Solution:
    def numMagicSquaresInside(self, grid: List[List[int]]) -> int:
        def is_magic(square):
            nums = set()
            for row in square:
                for num in row:
                    if num < 1 or num > 9:
                        return False
                    nums.add(num)
            if len(nums) != 9:
                return False

            row_sums = [sum(row) for row in square]
            col_sums = [sum(square[i][j] for i in range(3)) for j in range(3)]
            diag1 = sum(square[i][i] for i in range(3))
            diag2 = sum(square[i][2 - i] for i in range(3))

            all_sums = row_sums + col_sums + [diag1, diag2]
            return all(s == 15 for s in all_sums)

        count = 0
        rows = len(grid)
        cols = len(grid[0]) if rows > 0 else 0

        for i in range(rows - 2):
            for j in range(cols - 2):
                square = [
                    [grid[i][j], grid[i][j+1], grid[i][j+2]],
                    [grid[i+1][j], grid[i+1][j+1], grid[i+1][j+2]],
                    [grid[i+2][j], grid[i+2][j+1], grid[i+2][j+2]]
                ]
                if is_magic(square):
                    count += 1
        return count