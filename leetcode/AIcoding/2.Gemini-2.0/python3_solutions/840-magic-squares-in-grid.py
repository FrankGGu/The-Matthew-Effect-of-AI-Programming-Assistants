class Solution:
    def numMagicSquaresInside(self, grid: List[List[int]]) -> int:
        def is_magic_square(grid, r, c):
            if r + 2 >= len(grid) or c + 2 >= len(grid):
                return False
            nums = []
            for i in range(r, r + 3):
                for j in range(c, c + 3):
                    nums.append(grid[i][j])
            if len(set(nums)) != 9 or min(nums) != 1 or max(nums) != 9:
                return False
            row_sums = [sum(grid[i][c:c+3]) for i in range(r, r+3)]
            col_sums = [sum(grid[i][j] for i in range(r, r+3)) for j in range(c, c+3)]
            diag1 = sum(grid[r+i][c+i] for i in range(3))
            diag2 = sum(grid[r+i][c+2-i] for i in range(3))
            if row_sums[0] != row_sums[1] or row_sums[0] != row_sums[2]:
                return False
            if col_sums[0] != col_sums[1] or col_sums[0] != col_sums[2]:
                return False
            if row_sums[0] != col_sums[0] or row_sums[0] != diag1 or row_sums[0] != diag2:
                return False
            return True

        count = 0
        for r in range(len(grid)):
            for c in range(len(grid[0])):
                if is_magic_square(grid, r, c):
                    count += 1
        return count