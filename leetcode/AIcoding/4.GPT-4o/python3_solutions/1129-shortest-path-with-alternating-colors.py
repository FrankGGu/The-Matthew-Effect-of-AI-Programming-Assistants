from collections import deque, defaultdict

class Solution:
    def shortestAlternatingPaths(self, n: int, red_edges: List[List[int]], blue_edges: List[List[int]]) -> List[int]:
        graph = defaultdict(list)
        for u, v in red_edges:
            graph[u].append((v, 0))
        for u, v in blue_edges:
            graph[u].append((v, 1))

        dist = [[float('inf')] * 2 for _ in range(n)]
        dist[0] = [0, 0]

        queue = deque([(0, 0), (0, 1)])

        while queue:
            node, color = queue.popleft()
            for neighbor, edge_color in graph[node]:
                if edge_color != color and dist[neighbor][edge_color] == float('inf'):
                    dist[neighbor][edge_color] = dist[node][color] + 1
                    queue.append((neighbor, edge_color))

        result = []
        for i in range(n):
            min_dist = min(dist[i])
            result.append(min_dist if min_dist != float('inf') else -1)

        return result