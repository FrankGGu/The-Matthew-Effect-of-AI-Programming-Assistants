class Solution:
    def minCostConnectPoints(self, points: List[List[int]]) -> int:
        n = len(points)
        if n == 1:
            return 0
        edges = []
        for i in range(n):
            for j in range(i + 1, n):
                x1, y1 = points[i]
                x2, y2 = points[j]
                cost = abs(x1 - x2) + abs(y1 - y2)
                edges.append((cost, i, j))

        edges.sort()
        parent = list(range(n))

        def find(u):
            while parent[u] != u:
                parent[u] = parent[parent[u]]
                u = parent[u]
            return u

        def union(u, v):
            root_u = find(u)
            root_v = find(v)
            if root_u != root_v:
                parent[root_v] = root_u

        total_cost = 0
        edges_used = 0
        for cost, u, v in edges:
            if find(u) != find(v):
                union(u, v)
                total_cost += cost
                edges_used += 1
                if edges_used == n - 1:
                    break
        return total_cost