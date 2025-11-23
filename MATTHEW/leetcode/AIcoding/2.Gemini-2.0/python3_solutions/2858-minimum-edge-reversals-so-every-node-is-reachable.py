from collections import defaultdict, deque

class Solution:
    def minEdgeReversals(self, n: int, edges: list[list[int]]) -> list[int]:
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append((v, 0))
            graph[v].append((u, 1))

        def bfs(start_node):
            reversals = [float('inf')] * n
            reversals[start_node] = 0
            queue = deque([(start_node, 0)])

            while queue:
                node, cost = queue.popleft()
                for neighbor, edge_cost in graph[node]:
                    if reversals[neighbor] == float('inf'):
                        reversals[neighbor] = cost + edge_cost
                        queue.append((neighbor, reversals[neighbor]))
            return reversals

        result = []
        for i in range(n):
            reversals = bfs(i)
            count = 0
            for r in reversals:
                if r != float('inf'):
                    count += r
            result.append(count)

        return result