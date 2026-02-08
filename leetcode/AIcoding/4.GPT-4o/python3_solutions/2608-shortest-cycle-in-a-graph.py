from collections import defaultdict, deque

class Solution:
    def findShortestCycle(self, n: int, edges: List[List[int]]) -> int:
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        def bfs(start):
            queue = deque([(start, -1, 0)])
            visited = {}
            while queue:
                node, parent, depth = queue.popleft()
                if node in visited:
                    return depth - visited[node]
                visited[node] = depth
                for neighbor in graph[node]:
                    if neighbor != parent:
                        queue.append((neighbor, node, depth + 1))
            return float('inf')

        shortest_cycle = float('inf')
        for i in range(n):
            cycle_length = bfs(i)
            shortest_cycle = min(shortest_cycle, cycle_length)

        return shortest_cycle if shortest_cycle != float('inf') else -1