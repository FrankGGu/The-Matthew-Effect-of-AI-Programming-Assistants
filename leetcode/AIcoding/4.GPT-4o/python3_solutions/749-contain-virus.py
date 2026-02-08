class Solution:
    def containVirus(self, isInfected: List[List[int]]) -> int:
        m, n = len(isInfected), len(isInfected[0])

        def get_regions():
            regions = []
            visited = set()

            def dfs(x, y):
                stack = [(x, y)]
                region = [(x, y)]
                walls = 0

                while stack:
                    cx, cy = stack.pop()
                    for dx, dy in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
                        nx, ny = cx + dx, cy + dy
                        if 0 <= nx < m and 0 <= ny < n:
                            if isInfected[nx][ny] == 1 and (nx, ny) not in visited:
                                visited.add((nx, ny))
                                region.append((nx, ny))
                                stack.append((nx, ny))
                            elif isInfected[nx][ny] == 0:
                                walls += 1
                return region, walls

            for i in range(m):
                for j in range(n):
                    if isInfected[i][j] == 1 and (i, j) not in visited:
                        visited.add((i, j))
                        region, walls = dfs(i, j)
                        regions.append((region, walls))
            return regions

        def spread_infection():
            new_infected = set()
            for region, walls in regions:
                for x, y in region:
                    for dx, dy in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
                        nx, ny = x + dx, y + dy
                        if 0 <= nx < m and 0 <= ny < n and isInfected[nx][ny] == 0:
                            new_infected.add((nx, ny))
            return new_infected

        total_cost = 0
        while True:
            regions = get_regions()
            if not regions:
                break
            max_region = max(regions, key=lambda x: x[1])
            total_cost += max_region[1]
            new_infected = spread_infection()

            for i in range(m):
                for j in range(n):
                    if isInfected[i][j] == 1 and (i, j) not in max_region[0]:
                        isInfected[i][j] = 0
            for x, y in new_infected:
                isInfected[x][y] = 1

        return total_cost