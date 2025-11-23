class Solution:
    def findFarmland(self, land: List[List[int]]) -> List[List[int]]:
        m, n = len(land), len(land[0])
        result = []

        for i in range(m):
            for j in range(n):
                if land[i][j] == 1:
                    r1, c1 = i, j
                    r2, c2 = i, j

                    while r2 + 1 < m and land[r2 + 1][j] == 1:
                        r2 += 1
                    while c2 + 1 < n and land[r1][c2 + 1] == 1:
                        c2 += 1

                    for x in range(r1, r2 + 1):
                        for y in range(c1, c2 + 1):
                            land[x][y] = 0

                    result.append([r1, c1, r2, c2])

        return result