class Solution:
    def tilingRectangle(self, n: int, m: int) -> int:
        if n > m:
            n, m = m, n

        memo = {}

        initial_grid = [[0] * m for _ in range(n)]

        def solve(current_grid_tuple):
            if current_grid_tuple in memo:
                return memo[current_grid_tuple]

            r, c = -1, -1
            for i in range(n):
                for j in range(m):
                    if current_grid_tuple[i][j] == 0:
                        r, c = i, j
                        break
                if r != -1:
                    break

            if r == -1:
                return 0

            min_squares = float('inf')

            current_grid_list = [list(row) for row in current_grid_tuple]

            max_s = min(n - r, m - c)

            for s in range(max_s, 0, -1):
                can_place = True
                for i in range(r, r + s):
                    for j in range(c, c + s):
                        if current_grid_list[i][j] == 1:
                            can_place = False
                            break
                    if not can_place:
                        break

                if can_place:
                    for i in range(r, r + s):
                        for j in range(c, c + s):
                            current_grid_list[i][j] = 1

                    next_grid_tuple = tuple(tuple(row) for row in current_grid_list)
                    res = 1 + solve(next_grid_tuple)
                    min_squares = min(min_squares, res)

                    for i in range(r, r + s):
                        for j in range(c, c + s):
                            current_grid_list[i][j] = 0

            memo[current_grid_tuple] = min_squares
            return min_squares

        initial_grid_tuple = tuple(tuple(row) for row in initial_grid)
        return solve(initial_grid_tuple)