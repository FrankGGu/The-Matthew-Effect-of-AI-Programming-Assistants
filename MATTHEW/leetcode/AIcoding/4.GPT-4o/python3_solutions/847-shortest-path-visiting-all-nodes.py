from collections import deque

class Solution:
    def shortestPathLength(self, graph: List[List[int]]) -> int:
        n = len(graph)
        if n == 1:
            return 0

        queue = deque()
        visited = set()
        for i in range(n):
            queue.append((i, 1 << i))
            visited.add((i, 1 << i))

        steps = 0

        while queue:
            for _ in range(len(queue)):
                node, mask = queue.popleft()
                if mask == (1 << n) - 1:
                    return steps

                for neighbor in graph[node]:
                    new_mask = mask | (1 << neighbor)
                    if (neighbor, new_mask) not in visited:
                        visited.add((neighbor, new_mask))
                        queue.append((neighbor, new_mask))
            steps += 1

        return -1