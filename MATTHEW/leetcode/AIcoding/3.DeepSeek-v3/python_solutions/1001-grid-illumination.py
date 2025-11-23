from collections import defaultdict

class Solution:
    def gridIllumination(self, n: int, lamps: List[List[int]], queries: List[List[int]]) -> List[int]:
        lamp_set = set()
        row_counts = defaultdict(int)
        col_counts = defaultdict(int)
        diag1_counts = defaultdict(int)
        diag2_counts = defaultdict(int)

        for x, y in lamps:
            if (x, y) not in lamp_set:
                lamp_set.add((x, y))
                row_counts[x] += 1
                col_counts[y] += 1
                diag1_counts[x - y] += 1
                diag2_counts[x + y] += 1

        result = []
        directions = [(-1, -1), (-1, 0), (-1, 1),
                      (0, -1), (0, 0), (0, 1),
                      (1, -1), (1, 0), (1, 1)]

        for x, y in queries:
            illuminated = 0
            if row_counts[x] > 0 or col_counts[y] > 0 or diag1_counts[x - y] > 0 or diag2_counts[x + y] > 0:
                illuminated = 1
            result.append(illuminated)

            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if (nx, ny) in lamp_set:
                    lamp_set.remove((nx, ny))
                    row_counts[nx] -= 1
                    col_counts[ny] -= 1
                    diag1_counts[nx - ny] -= 1
                    diag2_counts[nx + ny] -= 1

        return result