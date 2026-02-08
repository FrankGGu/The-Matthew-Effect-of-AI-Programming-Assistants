def containVirus(island: List[List[int]]) -> int:
    m, n = len(island), len(island[0])
    def get_infected_area(r, c):
        queue = deque([(r, c)])
        visited = set([(r, c)])
        area = 0
        walls = 0
        while queue:
            x, y = queue.popleft()
            area += 1
            for dx, dy in [(0, 1), (1, 0), (0, -1), (-1, 0)]:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n:
                    if island[nx][ny] == 1 and (nx, ny) not in visited:
                        visited.add((nx, ny))
                        queue.append((nx, ny))
                    elif island[nx][ny] == 0:
                        walls += 1
        return area, walls, visited

    total_walls = 0
    while True:
        areas = []
        walls = []
        visited = set()
        for i in range(m):
            for j in range(n):
                if island[i][j] == 1 and (i, j) not in visited:
                    area, wall, new_visited = get_infected_area(i, j)
                    areas.append(area)
                    walls.append(wall)
                    visited.update(new_visited)

        if not areas:
            break

        max_area_index = walls.index(max(walls))
        total_walls += walls[max_area_index]

        for i in range(m):
            for j in range(n):
                if (i, j) in visited and (i, j) not in get_infected_area(i, j)[2]:
                    island[i][j] = 0
                elif island[i][j] == 1 and (i, j) not in visited:
                    island[i][j] = -1

        for i in range(m):
            for j in range(n):
                if island[i][j] == -1:
                    island[i][j] = 1

    return total_walls