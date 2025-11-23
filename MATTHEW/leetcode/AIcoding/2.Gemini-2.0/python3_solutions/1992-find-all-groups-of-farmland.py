class Solution:
    def findFarmland(self, land: List[List[int]]) -> List[List[int]]:
        m, n = len(land), len(land[0])
        result = []

        def dfs(i, j):
            if i < 0 or i >= m or j < 0 or j >= n or land[i][j] == 0:
                return
            land[i][j] = 0
            dfs(i + 1, j)
            dfs(i, j + 1)

        for i in range(m):
            for j in range(n):
                if land[i][j] == 1:
                    x1, y1 = i, j
                    x2, y2 = i, j

                    q = [(i, j)]
                    land[i][j] = 0

                    while q:
                        curr_x, curr_y = q.pop(0)
                        x2 = max(x2, curr_x)
                        y2 = max(y2, curr_y)

                        if curr_x + 1 < m and land[curr_x + 1][curr_y] == 1:
                            q.append((curr_x + 1, curr_y))
                            land[curr_x + 1][curr_y] = 0

                        if curr_y + 1 < n and land[curr_x][curr_y + 1] == 1:
                            q.append((curr_x, curr_y + 1))
                            land[curr_x][curr_y + 1] = 0

                    result.append([x1, y1, x2, y2])

        return result