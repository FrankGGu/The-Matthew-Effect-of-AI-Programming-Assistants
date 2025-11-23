import collections

class Solution:
    def latestDayToCross(self, row: int, col: int, cells: list[list[int]]) -> int:

        def can_cross(day_num: int) -> bool:
            grid = [[0] * col for _ in range(row)]

            for i in range(day_num):
                r_water, c_water = cells[i][0] - 1, cells[i][1] - 1
                grid[r_water][c_water] = 1

            q = collections.deque()
            visited = [[False] * col for _ in range(row)]

            for c_start in range(col):
                if grid[0][c_start] == 0:
                    q.append((0, c_start))
                    visited[0][c_start] = True

            directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

            while q:
                r, c = q.popleft()

                if r == row - 1:
                    return True

                for dr, dc in directions:
                    nr, nc = r + dr, c + dc

                    if 0 <= nr < row and 0 <= nc < col and \
                       grid[nr][nc] == 0 and not visited[nr][nc]:
                        visited[nr][nc] = True
                        q.append((nr, nc))

            return False

        left = 1
        right = row * col
        ans = 0

        while left <= right:
            mid = left + (right - left) // 2
            if can_cross(mid):
                ans = mid
                left = mid + 1
            else:
                right = mid - 1

        return ans