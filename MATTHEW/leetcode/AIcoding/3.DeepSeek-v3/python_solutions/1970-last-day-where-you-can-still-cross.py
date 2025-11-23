class Solution:
    def latestDayToCross(self, row: int, col: int, cells: List[List[int]]) -> int:
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        def canCross(day):
            grid = [[0] * col for _ in range(row)]
            for i in range(day):
                x, y = cells[i][0] - 1, cells[i][1] - 1
                grid[x][y] = 1

            queue = deque()
            for j in range(col):
                if grid[0][j] == 0:
                    queue.append((0, j))
                    grid[0][j] = 1

            while queue:
                x, y = queue.popleft()
                if x == row - 1:
                    return True
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < row and 0 <= ny < col and grid[nx][ny] == 0:
                        grid[nx][ny] = 1
                        queue.append((nx, ny))
            return False

        left, right = 0, len(cells)
        answer = 0
        while left <= right:
            mid = (left + right) // 2
            if canCross(mid):
                answer = mid
                left = mid + 1
            else:
                right = mid - 1
        return answer