class Solution:
    def latestDayToCross(self, row: int, col: int, cells: List[List[int]]) -> int:
        def canCross(day):
            grid = [[0] * col for _ in range(row)]
            for i in range(day):
                grid[cells[i][0] - 1][cells[i][1] - 1] = 1

            def bfs():
                queue = deque()
                for j in range(col):
                    if grid[0][j] == 0:
                        queue.append((0, j))
                while queue:
                    r, c = queue.popleft()
                    if r == row - 1:
                        return True
                    for dr, dc in [(1, 0), (0, 1), (0, -1)]:
                        nr, nc = r + dr, c + dc
                        if 0 <= nr < row and 0 <= nc < col and grid[nr][nc] == 0:
                            grid[nr][nc] = 1
                            queue.append((nr, nc))
                return False

            return bfs()

        left, right = 1, len(cells)
        while left < right:
            mid = (left + right + 1) // 2
            if canCross(mid):
                left = mid
            else:
                right = mid - 1
        return left