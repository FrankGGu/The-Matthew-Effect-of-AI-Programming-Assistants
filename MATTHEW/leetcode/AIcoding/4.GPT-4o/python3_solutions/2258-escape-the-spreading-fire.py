from collections import deque

class Solution:
    def escapeFire(self, grid: List[List[str]]) -> int:
        m, n = len(grid), len(grid[0])
        fire_time = [[float('inf')] * n for _ in range(m)]
        person_time = [[float('inf')] * n for _ in range(m)]
        fire_queue = deque()
        person_queue = deque()

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 'F':
                    fire_queue.append((i, j))
                    fire_time[i][j] = 0
                elif grid[i][j] == 'P':
                    person_queue.append((i, j))
                    person_time[i][j] = 0

        directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

        while fire_queue:
            x, y = fire_queue.popleft()
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and grid[nx][ny] == '.' and fire_time[nx][ny] == float('inf'):
                    fire_time[nx][ny] = fire_time[x][y] + 1
                    fire_queue.append((nx, ny))

        while person_queue:
            x, y = person_queue.popleft()
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and (grid[nx][ny] == '.' or grid[nx][ny] == 'E') and person_time[nx][ny] == float('inf'):
                    person_time[nx][ny] = person_time[x][y] + 1
                    person_queue.append((nx, ny))

        min_time = float('inf')
        for i in range(m):
            for j in range(n):
                if grid[i][j] == 'E' and person_time[i][j] < fire_time[i][j]:
                    min_time = min(min_time, person_time[i][j])

        return min_time + 1 if min_time != float('inf') else -1