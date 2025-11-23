class Solution:
    def findFarmland(self, land: List[List[int]]) -> List[List[int]]:
        if not land:
            return []

        rows, cols = len(land), len(land[0])
        visited = [[False] * cols for _ in range(rows)]
        result = []

        def dfs(r, c):
            nonlocal r0, c0, r1, c1
            if r < 0 or r >= rows or c < 0 or c >= cols or land[r][c] == 0 or visited[r][c]:
                return
            visited[r][c] = True
            r0, c0 = min(r0, r), min(c0, c)
            r1, c1 = max(r1, r), max(c1, c)
            for dr, dc in [(0, 1), (1, 0), (0, -1), (-1, 0)]:
                dfs(r + dr, c + dc)

        for r in range(rows):
            for c in range(cols):
                if land[r][c] == 1 and not visited[r][c]:
                    r0, c0, r1, c1 = r, c, r, c
                    dfs(r, c)
                    result.append([r0, c0, r1, c1])

        return result