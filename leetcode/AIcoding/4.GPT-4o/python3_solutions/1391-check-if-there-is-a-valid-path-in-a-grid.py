class Solution:
    def hasValidPath(self, grid: List[List[int]]) -> bool:
        from collections import deque

        rows, cols = len(grid), len(grid[0])
        directions = {
            1: [(0, 1), (0, -1)],
            2: [(1, 0), (-1, 0)],
            3: [(0, 1), (1, 0)],
            4: [(0, -1), (1, 0)],
            5: [(0, 1), (-1, 0)],
            6: [(0, -1), (-1, 0)]
        }

        def can_connect(type1, type2, dir1, dir2):
            return (dir1, dir2) in {(0, 1), (1, 0)} if type1 in {1, 3, 5} and type2 in {1, 4, 6} else \
                   (dir1, dir2) in {(0, -1), (1, 0)} if type1 in {1, 4, 6} and type2 in {1, 3, 5} else \
                   (dir1, dir2) in {(1, 0), (0, 1)} if type1 in {2, 3, 4} and type2 in {2, 5, 6} else \
                   (dir1, dir2) in {(1, 0), (0, -1)} if type1 in {2, 5, 6} and type2 in {2, 3, 4} else False

        visited = set()
        queue = deque([(0, 0)])
        visited.add((0, 0))

        while queue:
            x, y = queue.popleft()
            if (x, y) == (rows - 1, cols - 1):
                return True

            for dx, dy in directions[grid[x][y]]:
                nx, ny = x + dx, y + dy
                if 0 <= nx < rows and 0 <= ny < cols and (nx, ny) not in visited:
                    if can_connect(grid[x][y], grid[nx][ny], dx, dy):
                        visited.add((nx, ny))
                        queue.append((nx, ny))

        return False