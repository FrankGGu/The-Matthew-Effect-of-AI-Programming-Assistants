class Solution:
    def containVirus(self, isInfected: list[list[int]]) -> int:
        m, n = len(isInfected), len(isInfected[0])
        ans = 0
        while True:
            regions = []
            borders = []
            visited = set()
            for i in range(m):
                for j in range(n):
                    if isInfected[i][j] == 1 and (i, j) not in visited:
                        region = set()
                        border = 0
                        q = [(i, j)]
                        reg_visited = set()
                        while q:
                            x, y = q.pop(0)
                            if (x, y) in reg_visited:
                                continue
                            reg_visited.add((x, y))
                            region.add((x, y))
                            visited.add((x, y))
                            for dx, dy in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                                nx, ny = x + dx, y + dy
                                if 0 <= nx < m and 0 <= ny < n:
                                    if isInfected[nx][ny] == 1:
                                        if (nx, ny) not in reg_visited:
                                            q.append((nx, ny))
                                    else:
                                        border += 1
                                else:
                                    border += 1
                        regions.append(region)
                        borders.append(border)

            if not regions:
                break

            max_threat_idx = 0
            max_threat = 0
            threats = []
            for i in range(len(regions)):
                threat = set()
                for x, y in regions[i]:
                    for dx, dy in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                        nx, ny = x + dx, y + dy
                        if 0 <= nx < m and 0 <= ny < n and isInfected[nx][ny] == 0:
                            threat.add((nx, ny))
                threats.append(len(threat))
                if len(threat) > max_threat:
                    max_threat = len(threat)
                    max_threat_idx = i

            ans += borders[max_threat_idx]

            for i in range(len(regions)):
                if i != max_threat_idx:
                    for x, y in regions[i]:
                        for dx, dy in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                            nx, ny = x + dx, y + dy
                            if 0 <= nx < m and 0 <= ny < n and isInfected[nx][ny] == 0:
                                isInfected[nx][ny] = 1

            for x, y in regions[max_threat_idx]:
                isInfected[x][y] = -1
        return ans