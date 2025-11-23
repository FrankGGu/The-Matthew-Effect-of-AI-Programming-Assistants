class Solution:
    def hasValidPath(self, grid: List[List[int]]) -> bool:
        m, n = len(grid), len(grid[0])
        visited = set()

        def dfs(i, j):
            if (i, j) == (m - 1, n - 1):
                return True
            if (i, j) in visited:
                return False
            visited.add((i, j))

            street = grid[i][j]

            if street == 1:
                neighbors = [(i, j - 1), (i, j + 1)]
            elif street == 2:
                neighbors = [(i - 1, j), (i + 1, j)]
            elif street == 3:
                neighbors = [(i, j - 1), (i + 1, j)]
            elif street == 4:
                neighbors = [(i, j + 1), (i + 1, j)]
            elif street == 5:
                neighbors = [(i, j - 1), (i - 1, j)]
            else:
                neighbors = [(i, j + 1), (i - 1, j)]

            for ni, nj in neighbors:
                if 0 <= ni < m and 0 <= nj < n:
                    next_street = grid[ni][nj]

                    if street == 1:
                        if (nj == j - 1 and (next_street == 1 or next_street == 4 or next_street == 6)) or \
                           (nj == j + 1 and (next_street == 1 or next_street == 3 or next_street == 5)):
                            if dfs(ni, nj):
                                return True
                    elif street == 2:
                        if (ni == i - 1 and (next_street == 2 or next_street == 3 or next_street == 4)) or \
                           (ni == i + 1 and (next_street == 2 or next_street == 5 or next_street == 6)):
                            if dfs(ni, nj):
                                return True
                    elif street == 3:
                        if (nj == j - 1 and (next_street == 1 or next_street == 4 or next_street == 6)) or \
                           (ni == i + 1 and (next_street == 2 or next_street == 5 or next_street == 6)):
                            if dfs(ni, nj):
                                return True
                    elif street == 4:
                        if (nj == j + 1 and (next_street == 1 or next_street == 3 or next_street == 5)) or \
                           (ni == i + 1 and (next_street == 2 or next_street == 5 or next_street == 6)):
                            if dfs(ni, nj):
                                return True
                    elif street == 5:
                        if (nj == j - 1 and (next_street == 1 or next_street == 4 or next_street == 6)) or \
                           (ni == i - 1 and (next_street == 2 or next_street == 3 or next_street == 4)):
                            if dfs(ni, nj):
                                return True
                    else:
                        if (nj == j + 1 and (next_street == 1 or next_street == 3 or next_street == 5)) or \
                           (ni == i - 1 and (next_street == 2 or next_street == 3 or next_street == 4)):
                            if dfs(ni, nj):
                                return True

            return False

        return dfs(0, 0)