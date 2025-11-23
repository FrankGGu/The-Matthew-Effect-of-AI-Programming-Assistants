class Solution:
    def findFarmland(self, land: list[list[int]]) -> list[list[int]]:
        rows = len(land)
        cols = len(land[0])
        result = []

        def dfs(r, c):
            nonlocal max_r, max_c
            if not (0 <= r < rows and 0 <= c < cols and land[r][c] == 1):
                return

            land[r][c] = 0  # Mark as visited
            max_r = max(max_r, r)
            max_c = max(max_c, c)

            dfs(r + 1, c)
            dfs(r - 1, c)
            dfs(r, c + 1)
            dfs(r, c - 1)

        for r in range(rows):
            for c in range(cols):
                if land[r][c] == 1:
                    # Found a new farmland group
                    min_r, min_c = r, c
                    max_r, max_c = r, c  # Initialize max_r, max_c for the current group
                    dfs(r, c)
                    result.append([min_r, min_c, max_r, max_c])

        return result