class Solution:
    def isEscapePossible(self, blocked: List[List[int]], source: List[int], target: List[int]) -> bool:
        blocked_set = set(tuple(b) for b in blocked)
        return self.bfs(source, target, blocked_set) and self.bfs(target, source, blocked_set)

    def bfs(self, start, end, blocked_set):
        if len(blocked_set) < 2:
            return True
        queue = deque([start])
        visited = set([tuple(start)])
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        while queue:
            x, y = queue.popleft()
            if abs(x - end[0]) + abs(y - end[1]) >= 200: 
                return True

            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < 10**6 and 0 <= ny < 10**6 and (nx, ny) not in visited and (nx, ny) not in blocked_set:
                    visited.add((nx, ny))
                    queue.append((nx, ny))

        return False