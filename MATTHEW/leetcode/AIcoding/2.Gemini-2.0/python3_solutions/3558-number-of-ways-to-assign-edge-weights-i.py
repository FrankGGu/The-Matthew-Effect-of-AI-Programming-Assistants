from collections import defaultdict

class Solution:
    def minEdgeWeight(self, n: int, edges: list[list[int]], source: int, destination: int) -> int:
        adj = defaultdict(list)
        for u, v, w in edges:
            adj[u].append((v, w))
            adj[v].append((u, w))

        q = [(source, 0)]
        visited = {source}
        min_weight = float('inf')

        while q:
            node, weight = q.pop(0)

            if node == destination:
                min_weight = min(min_weight, weight)
                continue

            for neighbor, w in adj[node]:
                if neighbor not in visited:
                    visited.add(neighbor)
                    q.append((neighbor, weight + w))

        if min_weight == float('inf'):
            return -1
        else:
            return min_weight

    def waysToAssign(self, n: int, edges: list[list[int]]) -> int:
        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        def bfs(start, end):
            q = [(start, [start])]
            paths = []
            while q:
                node, path = q.pop(0)
                if node == end:
                    paths.append(path)
                else:
                    for neighbor in adj[node]:
                        if neighbor not in path:
                            q.append((neighbor, path + [neighbor]))
            return paths

        paths = bfs(edges[0][0], edges[0][1])
        if not paths:
            return 0

        min_weight = self.minEdgeWeight(n, [edge + [1] for edge in edges], edges[0][0], edges[0][1])

        if min_weight == -1:
            return 0

        count = 0
        for i in range(1, 1001):
            min_w = self.minEdgeWeight(n, [edge + [i] for edge in edges], edges[0][0], edges[0][1])
            if min_w == min_weight:
                count += 1

        return count