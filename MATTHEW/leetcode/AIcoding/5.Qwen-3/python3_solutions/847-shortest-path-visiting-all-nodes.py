from collections import deque

class Solution:
    def shortestPathLength(self, graph: list[list[int]]) -> int:
        n = len(graph)
        target = (1 << n) - 1
        visited = set()
        q = deque()

        for i in range(n):
            mask = 1 << i
            q.append((i, mask))
            visited.add((i, mask))

        steps = 0
        while q:
            for _ in range(len(q)):
                node, mask = q.popleft()
                if mask == target:
                    return steps
                for neighbor in graph[node]:
                    new_mask = mask | (1 << neighbor)
                    if (neighbor, new_mask) not in visited:
                        visited.add((neighbor, new_mask))
                        q.append((neighbor, new_mask))
            steps += 1

        return -1