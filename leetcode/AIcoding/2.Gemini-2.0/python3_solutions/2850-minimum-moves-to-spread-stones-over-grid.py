class Solution:
    def minimumMoves(self, grid: List[List[int]]) -> int:
        zeros = []
        excess = []
        for i in range(3):
            for j in range(3):
                if grid[i][j] == 0:
                    zeros.append((i, j))
                elif grid[i][j] > 1:
                    excess.append((i, j, grid[i][j] - 1))

        n = len(zeros)
        m = len(excess)

        dp = {}

        def solve(zero_idx, excess_idx, used):
            if zero_idx == n:
                return 0

            if (zero_idx, excess_idx, used) in dp:
                return dp[(zero_idx, excess_idx, used)]

            min_moves = float('inf')

            for i in range(m):
                if (used >> i) & 1 == 0:
                    zero_row, zero_col = zeros[zero_idx]
                    excess_row, excess_col, count = excess[i]

                    moves = abs(zero_row - excess_row) + abs(zero_col - excess_col)

                    if count == 1:
                        new_excess = excess[:i] + excess[i+1:]
                        new_m = len(new_excess)

                        new_min_moves = moves + solve(zero_idx + 1, 0, (1 << i) | used)
                        min_moves = min(min_moves, new_min_moves)
                    else:
                        new_excess = excess[:i] + [(excess_row, excess_col, count - 1)] + excess[i+1:]

                        temp_excess = excess[:]
                        temp_excess[i] = (excess_row, excess_col, count - 1)

                        new_min_moves = moves + solve(zero_idx + 1, 0, (1 << i) | used)
                        min_moves = min(min_moves, new_min_moves)

            dp[(zero_idx, excess_idx, used)] = min_moves
            return min_moves

        return solve(0, 0, 0)