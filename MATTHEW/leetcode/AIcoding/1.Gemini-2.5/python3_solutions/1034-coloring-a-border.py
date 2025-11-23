import collections

class Solution:
    def coloringBorder(self, grid: List[List[int]], r0: int, c0: int, color: int) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        original_color = grid[r0][c0]

        dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        q = collections.deque([(r0, c0)])
        visited = set([(r0, c0)])

        component_cells = []

        while q:
            r, c = q.popleft()
            component_cells.append((r, c))

            for dr, dc in dirs:
                nr, nc = r + dr, c + dc

                if 0 <= nr < m and 0 <= nc < n and grid[nr][nc] == original_color and (nr, nc) not in visited:
                    visited.add((nr, nc))
                    q.append((nr, nc))

        border_cells_to_color = []

        for r, c in component_cells:
            count_same_color_neighbors = 0
            for dr, dc in dirs:
                nr, nc = r + dr, c + dc

                if 0 <= nr < m and 0 <= nc < n:
                    if grid[nr][nc] == original_color:
                        count_same_color_neighbors += 1

            if count_same_color_neighbors < 4:
                border_cells_to_color.append((r, c))

        for r, c in border_cells_to_color:
            grid[r][c] = color

        return grid