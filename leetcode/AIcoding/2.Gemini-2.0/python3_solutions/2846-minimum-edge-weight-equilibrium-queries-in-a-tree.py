from collections import defaultdict

class Solution:
    def minOperationsQueries(self, n: int, edges: list[list[int]], queries: list[list[int]]) -> list[int]:
        adj = defaultdict(list)
        for u, v, w in edges:
            adj[u].append((v, w))
            adj[v].append((u, w))

        depth = [-1] * n
        parent = [[-1] * n for _ in range(15)]
        weight_counts = [[defaultdict(int) for _ in range(n)] for _ in range(15)]

        def dfs(node, par, dep, weight_count):
            depth[node] = dep
            parent[0][node] = par
            weight_counts[0][node] = weight_count

            for neighbor, weight in adj[node]:
                if neighbor != par:
                    new_weight_count = weight_count.copy()
                    new_weight_count[weight] += 1
                    dfs(neighbor, node, dep + 1, new_weight_count)

        dfs(0, -1, 0, defaultdict(int))

        for i in range(1, 15):
            for j in range(n):
                if parent[i - 1][j] != -1:
                    parent[i][j] = parent[i - 1][parent[i - 1][j]]

                    weight_counts[i][j] = weight_counts[i-1][j].copy()
                    for k, v in weight_counts[i-1][parent[i-1][j]].items():
                        weight_counts[i][j][k] += v

        def lca(u, v):
            if depth[u] < depth[v]:
                u, v = v, u

            diff = depth[u] - depth[v]
            for i in range(15):
                if (diff >> i) & 1:
                    u = parent[i][u]

            if u == v:
                return u

            for i in range(14, -1, -1):
                if parent[i][u] != -1 and parent[i][u] != parent[i][v]:
                    u = parent[i][u]
                    v = parent[i][v]

            return parent[0][u]

        def get_weight_counts(node, ancestor):
            counts = defaultdict(int)
            dep_diff = depth[node] - depth[ancestor]

            for i in range(15):
                if (dep_diff >> i) & 1:
                    for k, v in weight_counts[i][node].items():
                        counts[k] += v
                    node = parent[i][node]
            return counts

        result = []
        for u, v in queries:
            ancestor = lca(u, v)
            counts_u = get_weight_counts(u, ancestor)
            counts_v = get_weight_counts(v, ancestor)
            counts_ancestor = weight_counts[0][ancestor] if ancestor != 0 else defaultdict(int)

            total_edges = depth[u] + depth[v] - 2 * depth[ancestor]

            all_counts = defaultdict(int)
            for k, v in counts_u.items():
                all_counts[k] += v
            for k, v in counts_v.items():
                all_counts[k] += v

            max_weight = 0
            for weight, count in all_counts.items():
                max_weight = max(max_weight, count)

            result.append(total_edges - max_weight)

        return result