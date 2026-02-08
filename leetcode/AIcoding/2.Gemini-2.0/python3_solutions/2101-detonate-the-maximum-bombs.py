class Solution:
    def maximumDetonation(self, bombs: list[list[int]]) -> int:
        n = len(bombs)
        graph = [[] for _ in range(n)]
        for i in range(n):
            for j in range(n):
                if i != j:
                    x1, y1, r1 = bombs[i]
                    x2, y2, r2 = bombs[j]
                    if (x1 - x2)**2 + (y1 - y2)**2 <= r1**2:
                        graph[i].append(j)

        def bfs(start):
            q = [start]
            visited = {start}
            count = 0
            while q:
                curr = q.pop(0)
                count += 1
                for neighbor in graph[curr]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        q.append(neighbor)
            return count

        max_bombs = 0
        for i in range(n):
            max_bombs = max(max_bombs, bfs(i))

        return max_bombs