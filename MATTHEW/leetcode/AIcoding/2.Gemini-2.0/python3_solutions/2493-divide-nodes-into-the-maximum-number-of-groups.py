from collections import deque

class Solution:
    def magnificentSets(self, n: int, edges: list[list[int]]) -> int:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u - 1].append(v - 1)
            adj[v - 1].append(u - 1)

        colors = [-1] * n
        ans = 0

        def bfs(start_node):
            q = deque([(start_node, 0)])
            colors[start_node] = 0
            max_depth = 0
            while q:
                node, depth = q.popleft()
                max_depth = max(max_depth, depth)
                for neighbor in adj[node]:
                    if colors[neighbor] == -1:
                        colors[neighbor] = 1 - colors[node]
                        q.append((neighbor, depth + 1))
                    elif colors[neighbor] == colors[node]:
                        return -1
            return max_depth

        def find_max_distance(start_node):
            distances = [-1] * n
            distances[start_node] = 1
            q = deque([start_node])
            max_dist = 1
            while q:
                u = q.popleft()
                for v in adj[u]:
                    if distances[v] == -1:
                        distances[v] = distances[u] + 1
                        max_dist = max(max_dist, distances[v])
                        q.append(v)
            return max_dist

        groups = []
        for i in range(n):
            if colors[i] == -1:
                if bfs(i) == -1:
                    return -1
                max_dist = 0
                nodes_in_component = []
                for j in range(n):
                    if colors[j] != -1 and colors[j] != 2:
                        nodes_in_component.append(j)
                        colors[j] = 2

                for node in nodes_in_component:
                    max_dist = max(max_dist, find_max_distance(node))
                groups.append(max_dist)

        return sum(groups)