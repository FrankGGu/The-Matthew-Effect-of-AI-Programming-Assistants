class Solution:
    def minOperationsQueries(self, n: int, edges: List[List[int]], queries: List[List[int]]) -> List[int]:
        LOG = 14
        parent = [[-1] * n for _ in range(LOG)]
        depth = [0] * n
        adj = [[] for _ in range(n)]
        weight_counts = [[0] * 27 for _ in range(n)]

        for u, v, w in edges:
            adj[u].append((v, w))
            adj[v].append((u, w))

        stack = [(0, -1, 0)]
        while stack:
            u, p, d = stack.pop()
            parent[0][u] = p
            depth[u] = d
            for v, w in adj[u]:
                if v != p:
                    for i in range(27):
                        weight_counts[v][i] = weight_counts[u][i]
                    weight_counts[v][w] += 1
                    stack.append((v, u, d + 1))

        for k in range(1, LOG):
            for v in range(n):
                if parent[k-1][v] != -1:
                    parent[k][v] = parent[k-1][parent[k-1][v]]

        def get_lca(u, v):
            if depth[u] < depth[v]:
                u, v = v, u
            for k in range(LOG-1, -1, -1):
                if depth[u] - (1 << k) >= depth[v]:
                    u = parent[k][u]
            if u == v:
                return u
            for k in range(LOG-1, -1, -1):
                if parent[k][u] != -1 and parent[k][u] != parent[k][v]:
                    u = parent[k][u]
                    v = parent[k][v]
            return parent[0][u]

        res = []
        for u, v in queries:
            lca = get_lca(u, v)
            total = depth[u] + depth[v] - 2 * depth[lca]
            max_freq = 0
            for w in range(1, 27):
                cnt = weight_counts[u][w] + weight_counts[v][w] - 2 * weight_counts[lca][w]
                if cnt > max_freq:
                    max_freq = cnt
            res.append(total - max_freq)
        return res