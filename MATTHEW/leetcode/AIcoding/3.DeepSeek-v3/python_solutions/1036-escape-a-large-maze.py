class Solution:
    def isEscapePossible(self, blocked: List[List[int]], source: List[int], target: List[int]) -> bool:
        blocked = set(map(tuple, blocked))
        source, target = tuple(source), tuple(target)

        def bfs(start, end):
            queue = collections.deque([start])
            visited = {start}
            directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
            while queue:
                x, y = queue.popleft()
                if (x, y) == end or abs(x - start[0]) + abs(y - start[1]) > 200:
                    return True
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < 10**6 and 0 <= ny < 10**6 and (nx, ny) not in blocked and (nx, ny) not in visited:
                        visited.add((nx, ny))
                        queue.append((nx, ny))
                if len(visited) > 20000:
                    return True
            return False

        return bfs(source, target) and bfs(target, source)