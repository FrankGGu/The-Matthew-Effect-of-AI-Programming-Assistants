class Solution:
    def bicycleYard(self, position: List[int], terrain: List[List[int]], obstacle: List[List[int]]) -> List[List[int]]:
        from collections import deque
        m, n = len(terrain), len(terrain[0]) if terrain else 0
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        res = set()
        visited = {}
        q = deque()
        x, y = position
        q.append((x, y, 1))
        visited[(x, y, 1)] = True

        while q:
            i, j, speed = q.popleft()
            for di, dj in directions:
                ni, nj = i + di, j + dj
                if 0 <= ni < m and 0 <= nj < n:
                    delta = terrain[i][j] - terrain[ni][nj] - obstacle[ni][nj]
                    new_speed = speed + delta
                    if new_speed <= 0:
                        continue
                    if (ni, nj, new_speed) not in visited:
                        visited[(ni, nj, new_speed)] = True
                        q.append((ni, nj, new_speed))
                        if new_speed == 1 and [ni, nj] != position:
                            res.add((ni, nj))
        return sorted(res)