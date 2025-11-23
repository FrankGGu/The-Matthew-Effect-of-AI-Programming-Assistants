class Solution:
    def containVirus(self, isInfected: List[List[int]]) -> int:
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        m, n = len(isInfected), len(isInfected[0])
        result = 0

        while True:
            regions = []
            frontiers = []
            walls = []
            visited = [[False for _ in range(n)] for _ in range(m)]

            for i in range(m):
                for j in range(n):
                    if isInfected[i][j] == 1 and not visited[i][j]:
                        queue = deque([(i, j)])
                        visited[i][j] = True
                        region = [(i, j)]
                        frontier = set()
                        wall = 0

                        while queue:
                            x, y = queue.popleft()
                            for dx, dy in directions:
                                nx, ny = x + dx, y + dy
                                if 0 <= nx < m and 0 <= ny < n:
                                    if isInfected[nx][ny] == 1 and not visited[nx][ny]:
                                        visited[nx][ny] = True
                                        queue.append((nx, ny))
                                        region.append((nx, ny))
                                    elif isInfected[nx][ny] == 0:
                                        frontier.add((nx, ny))
                                        wall += 1
                        regions.append(region)
                        frontiers.append(frontier)
                        walls.append(wall)

            if not regions:
                break

            max_idx = 0
            max_size = len(frontiers[0])
            for i in range(1, len(frontiers)):
                if len(frontiers[i]) > max_size:
                    max_size = len(frontiers[i])
                    max_idx = i

            result += walls[max_idx]

            for i in range(len(regions)):
                if i == max_idx:
                    for x, y in regions[i]:
                        isInfected[x][y] = -1
                else:
                    for x, y in regions[i]:
                        for dx, dy in directions:
                            nx, ny = x + dx, y + dy
                            if 0 <= nx < m and 0 <= ny < n and isInfected[nx][ny] == 0:
                                isInfected[nx][ny] = 1

        return result