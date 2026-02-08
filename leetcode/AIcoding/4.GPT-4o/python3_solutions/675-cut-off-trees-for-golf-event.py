from collections import deque

class Solution:
    def cutOffTree(self, forest: List[List[int]]) -> int:
        def bfs(start, end):
            queue = deque([start])
            visited = {start}
            steps = 0

            while queue:
                for _ in range(len(queue)):
                    x, y = queue.popleft()
                    if (x, y) == end:
                        return steps
                    for dx, dy in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
                        nx, ny = x + dx, y + dy
                        if 0 <= nx < len(forest) and 0 <= ny < len(forest[0]) and (nx, ny) not in visited and forest[nx][ny] != 0:
                            visited.add((nx, ny))
                            queue.append((nx, ny))
                steps += 1
            return float('inf')

        trees = sorted((h, i, j) for i, row in enumerate(forest) for j, h in enumerate(row) if h > 1)
        total_steps = 0
        start = (0, 0)

        for height, x, y in trees:
            steps = bfs(start, (x, y))
            if steps == float('inf'):
                return -1
            total_steps += steps
            start = (x, y)

        return total_steps