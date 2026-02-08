class Solution:
    def largestIsland(self, grid: List[List[int]]) -> int:
        n = len(grid)
        index = {}
        island_id = 2
        area = [0] * 2501

        def dfs(x, y):
            stack = [(x, y)]
            count = 0
            while stack:
                cx, cy = stack.pop()
                if 0 <= cx < n and 0 <= cy < n and grid[cx][cy] == 1:
                    grid[cx][cy] = island_id
                    count += 1
                    for nx, ny in [(cx + 1, cy), (cx - 1, cy), (cx, cy + 1), (cx, ny - 1)]:
                        stack.append((nx, ny))
            return count

        for i in range(n):
            for j in range(n):
                if grid[i][j] == 1:
                    area[island_id] = dfs(i, j)
                    index[island_id] = (i, j)
                    island_id += 1

        max_area = max(area) if area else 0

        for i in range(n):
            for j in range(n):
                if grid[i][j] == 0:
                    seen = set()
                    current_area = 1
                    for nx, ny in [(i + 1, j), (i - 1, j), (i, j + 1), (i, j - 1)]:
                        if 0 <= nx < n and 0 <= ny < n and grid[nx][ny] > 1:
                            island = grid[nx][ny]
                            if island not in seen:
                                current_area += area[island]
                                seen.add(island)
                    max_area = max(max_area, current_area)

        return max_area