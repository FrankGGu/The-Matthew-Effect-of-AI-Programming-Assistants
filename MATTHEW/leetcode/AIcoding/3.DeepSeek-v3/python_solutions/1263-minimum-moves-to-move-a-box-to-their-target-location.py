from collections import deque

class Solution:
    def minPushBox(self, grid: List[List[str]]) -> int:
        m, n = len(grid), len(grid[0])
        box_pos = None
        target_pos = None
        player_pos = None

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 'B':
                    box_pos = (i, j)
                elif grid[i][j] == 'T':
                    target_pos = (i, j)
                elif grid[i][j] == 'S':
                    player_pos = (i, j)

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        def can_reach(player, box, dest):
            queue = deque([player])
            visited = set()
            visited.add(player)
            while queue:
                x, y = queue.popleft()
                if (x, y) == dest:
                    return True
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < m and 0 <= ny < n and (nx, ny) != box and grid[nx][ny] != '#' and (nx, ny) not in visited:
                        visited.add((nx, ny))
                        queue.append((nx, ny))
            return False

        queue = deque()
        queue.append((box_pos[0], box_pos[1], player_pos[0], player_pos[1], 0))
        visited = set()
        visited.add((box_pos[0], box_pos[1], player_pos[0], player_pos[1]))

        while queue:
            bx, by, px, py, pushes = queue.popleft()
            if (bx, by) == target_pos:
                return pushes
            for dx, dy in directions:
                new_bx, new_by = bx + dx, by + dy
                new_px, new_py = bx - dx, by - dy
                if 0 <= new_bx < m and 0 <= new_by < n and grid[new_bx][new_by] != '#':
                    if 0 <= new_px < m and 0 <= new_py < n and grid[new_px][new_py] != '#':
                        if (new_bx, new_by, bx, by) not in visited:
                            if can_reach((px, py), (bx, by), (new_px, new_py)):
                                visited.add((new_bx, new_by, bx, by))
                                queue.append((new_bx, new_by, bx, by, pushes + 1))
        return -1