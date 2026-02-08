class Solution:
    def minimumMoves(self, grid: list[list[int]]) -> int:
        excess_stones_coords = []
        deficit_cells_coords = []

        for r in range(3):
            for c in range(3):
                if grid[r][c] > 1:
                    for _ in range(grid[r][c] - 1):
                        excess_stones_coords.append((r, c))
                elif grid[r][c] == 0:
                    deficit_cells_coords.append((r, c))

        N = len(excess_stones_coords)

        if N == 0:
            return 0

        min_total_moves = float('inf')
        used_targets = [False] * N

        def solve(k, current_cost):
            nonlocal min_total_moves

            if k == N:
                min_total_moves = min(min_total_moves, current_cost)
                return

            if current_cost >= min_total_moves:
                return

            source_r, source_c = excess_stones_coords[k]

            for i in range(N):
                if not used_targets[i]:
                    target_r, target_c = deficit_cells_coords[i]

                    dist = abs(source_r - target_r) + abs(source_c - target_c)

                    used_targets[i] = True
                    solve(k + 1, current_cost + dist)
                    used_targets[i] = False

        solve(0, 0)
        return min_total_moves