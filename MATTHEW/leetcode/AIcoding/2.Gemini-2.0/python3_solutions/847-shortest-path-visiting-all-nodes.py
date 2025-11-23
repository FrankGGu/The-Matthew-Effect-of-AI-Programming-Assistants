from collections import deque

class Solution:
    def shortestPathLength(self, graph: list[list[int]]) -> int:
        n = len(graph)
        if n == 1:
            return 0

        q = deque()
        visited = set()

        for i in range(n):
            q.append((i, 1 << i, 0))
            visited.add((i, 1 << i))

        while q:
            node, mask, dist = q.popleft()

            for neighbor in graph[node]:
                new_mask = mask | (1 << neighbor)

                if new_mask == (1 << n) - 1:
                    return dist + 1

                if (neighbor, new_mask) not in visited:
                    visited.add((neighbor, new_mask))
                    q.append((neighbor, new_mask, dist + 1))

        return -1