from collections import defaultdict, deque

class Solution:
    def minEdgeReversals(self, edges: List[List[int]]) -> int:
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append((v, 0))
            graph[v].append((u, 1))

        def bfs(start):
            queue = deque([start])
            visited = set([start])
            reversals = 0

            while queue:
                node = queue.popleft()
                for neighbor, cost in graph[node]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append(neighbor)
                        reversals += cost

            return reversals

        total_reversals = bfs(0)
        return total_reversals