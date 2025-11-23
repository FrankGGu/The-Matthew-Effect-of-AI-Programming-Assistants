class Solution:
    def latestDayToCross(self, row: int, col: int, cells: List[List[int]]) -> int:
        def is_valid(r, c):
            return 0 <= r < row and 0 <= c < col

        def can_cross(day):
            grid = [[0] * col for _ in range(row)]
            for i in range(day):
                r, c = cells[i][0] - 1, cells[i][1] - 1
                grid[r][c] = 1

            q = collections.deque()
            visited = set()

            for c in range(col):
                if grid[0][c] == 0:
                    q.append((0, c))
                    visited.add((0, c))

            while q:
                r, c = q.popleft()
                if r == row - 1:
                    return True

                directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
                for dr, dc in directions:
                    nr, nc = r + dr, c + dc
                    if is_valid(nr, nc) and grid[nr][nc] == 0 and (nr, nc) not in visited:
                        q.append((nr, nc))
                        visited.add((nr, nc))

            return False

        left, right = 0, len(cells)
        ans = 0
        while left < right:
            mid = (left + right) // 2
            if can_cross(mid):
                ans = mid
                left = mid + 1
            else:
                right = mid

        return ans