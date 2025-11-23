class Solution:
    def extractMantra(self, matrix: List[str], mantra: str) -> int:
        m, n = len(matrix), len(matrix[0])
        l = len(mantra)
        from collections import deque
        q = deque()
        q.append((0, 0, 0))
        visited = set()
        visited.add((0, 0, 0))
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        steps = 0

        while q:
            for _ in range(len(q)):
                x, y, pos = q.popleft()
                if pos == l:
                    return steps
                if matrix[x][y] == mantra[pos]:
                    new_pos = pos + 1
                    if (x, y, new_pos) not in visited:
                        visited.add((x, y, new_pos))
                        q.append((x, y, new_pos))
                        if new_pos == l:
                            return steps + 1
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < m and 0 <= ny < n:
                        if (nx, ny, pos) not in visited:
                            visited.add((nx, ny, pos))
                            q.append((nx, ny, pos))
            steps += 1
        return -1