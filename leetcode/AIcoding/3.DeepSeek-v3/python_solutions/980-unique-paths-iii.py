class Solution:
    def uniquePathsIII(self, grid: List[List[int]]) -> int:
        rows, cols = len(grid), len(grid[0])
        start_r, start_c, end_r, end_c = 0, 0, 0, 0
        empty = 0

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 1:
                    start_r, start_c = r, c
                elif grid[r][c] == 2:
                    end_r, end_c = r, c
                elif grid[r][c] == 0:
                    empty += 1

        self.res = 0
        visited = set()

        def dfs(r, c, visited, walk):
            if r == end_r and c == end_c:
                if walk == empty + 1:
                    self.res += 1
                return
            if 0 <= r < rows and 0 <= c < cols and grid[r][c] != -1 and (r, c) not in visited:
                visited.add((r, c))
                for dr, dc in [(0, 1), (1, 0), (0, -1), (-1, 0)]:
                    dfs(r + dr, c + dc, visited, walk + 1)
                visited.remove((r, c))

        dfs(start_r, start_c, visited, 0)
        return self.res