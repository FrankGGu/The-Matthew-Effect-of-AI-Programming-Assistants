class Solution:
    def gridIllumination(self, n: int, lamps: List[List[int]], queries: List[List[int]]) -> List[int]:
        row = {}
        col = {}
        diag1 = {}
        diag2 = {}
        points = set()
        for r, c in lamps:
            if (r, c) in points:
                continue
            points.add((r, c))
            row[r] = row.get(r, 0) + 1
            col[c] = col.get(c, 0) + 1
            diag1[r - c] = diag1.get(r - c, 0) + 1
            diag2[r + c] = diag2.get(r + c, 0) + 1

        ans = []
        for r, c in queries:
            if row.get(r, 0) > 0 or col.get(c, 0) > 0 or diag1.get(r - c, 0) > 0 or diag2.get(r + c, 0) > 0:
                ans.append(1)
            else:
                ans.append(0)

            for i in range(-1, 2):
                for j in range(-1, 2):
                    nr, nc = r + i, c + j
                    if 0 <= nr < n and 0 <= nc < n and (nr, nc) in points:
                        points.remove((nr, nc))
                        row[nr] -= 1
                        col[nc] -= 1
                        diag1[nr - nc] -= 1
                        diag2[nr + nc] -= 1
                        if row[nr] == 0:
                            del row[nr]
                        if col[nc] == 0:
                            del col[nc]
                        if diag1[nr - nc] == 0:
                            del diag1[nr - nc]
                        if diag2[nr + nc] == 0:
                            del diag2[nr + nc]

        return ans