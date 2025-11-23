class Solution:
    def minimumMoves(self, grid: List[List[int]]) -> int:
        from itertools import permutations

        stones = []
        holes = []
        for i in range(3):
            for j in range(3):
                if grid[i][j] > 1:
                    stones.append((i, j, grid[i][j] - 1))
                elif grid[i][j] == 0:
                    holes.append((i, j))

        if not stones:
            return 0

        min_moves = float('inf')
        stone_pos = []
        for x, y, cnt in stones:
            for _ in range(cnt):
                stone_pos.append((x, y))

        hole_pos = holes.copy()

        for stone_perm in permutations(stone_pos):
            total = 0
            for (sx, sy), (hx, hy) in zip(stone_perm, hole_pos):
                total += abs(sx - hx) + abs(sy - hy)
                if total >= min_moves:
                    break
            if total < min_moves:
                min_moves = total

        return min_moves