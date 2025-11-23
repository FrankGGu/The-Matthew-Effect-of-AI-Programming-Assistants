from collections import deque

class Solution:
    def shortestPathLength(self, graph: List[List[int]]) -> int:
        n = len(graph)
        target_mask = (1 << n) - 1
        visited = set()
        queue = deque()

        for i in range(n):
            queue.append((i, 1 << i))
            visited.add((i, 1 << i))

        steps = 0
        while queue:
            size = len(queue)
            for _ in range(size):
                node, mask = queue.popleft()
                if mask == target_mask:
                    return steps
                for neighbor in graph[node]:
                    new_mask = mask | (1 << neighbor)
                    if (neighbor, new_mask) not in visited:
                        visited.add((neighbor, new_mask))
                        queue.append((neighbor, new_mask))
            steps += 1
        return -1