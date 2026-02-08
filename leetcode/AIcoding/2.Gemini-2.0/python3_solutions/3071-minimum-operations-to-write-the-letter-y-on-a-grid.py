class Solution:
    def minimumOperationsToWriteY(self, grid: List[List[int]]) -> int:
        n = len(grid)
        on_y = set()
        for i in range(n // 2):
            on_y.add((i, i))
            on_y.add((i, n - 1 - i))
        for i in range(n // 2, n):
            on_y.add((i, n // 2))

        count_on_y_zero = 0
        count_on_y_one = 0
        count_off_y_zero = 0
        count_off_y_one = 0

        for i in range(n):
            for j in range(n):
                if (i, j) in on_y:
                    if grid[i][j] == 0:
                        count_on_y_zero += 1
                    else:
                        count_on_y_one += 1
                else:
                    if grid[i][j] == 0:
                        count_off_y_zero += 1
                    else:
                        count_off_y_one += 1

        return min(count_on_y_one + count_off_y_zero, count_on_y_zero + count_off_y_one)