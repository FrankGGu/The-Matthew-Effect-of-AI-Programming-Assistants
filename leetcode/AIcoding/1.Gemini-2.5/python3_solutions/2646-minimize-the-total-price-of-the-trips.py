import collections

class Solution:
    def minimizeTotalPrice(self, n: int, edges: list[list[int]], prices: list[int], trips: list[list[int]]) -> int:
        adj = collections.defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        LOGN = n.bit_length()
        parent = [-1] * n
        depth = [0] * n
        up = [[-1] * LOGN for _ in range(n)]

        def dfs_lca_setup(u, p, d):
            parent[u] = p
            depth[u] = d
            up[u][0] = p
            for i in range(1, LOGN):
                if up[u][i-1] != -1:
                    up[u][i] = up[up[u][i-1]][i-1]
            for v in adj[u]:
                if v != p:
                    dfs_lca_setup(v, u, d + 1)

        dfs_lca_setup(0, -1, 0)

        def get_ancestor(u, k):
            for i in range(LOGN - 1, -1, -1):
                if u == -1: break
                if k & (1 << i):
                    u = up[u][i]
            return u

        def lca(u, v):
            if depth[u] < depth[v]:
                u, v = v, u

            u = get_ancestor(u, depth[u] - depth[v])

            if u == v:
                return u

            for i in range(LOGN - 1, -1, -1):
                if up[u][i] != up[v][i]:
                    u = up[u][i]
                    v = up[v][i]

            return parent[u]

        path_counts = [0] * n
        for s, t in trips:
            l = lca(s, t)
            path_counts[s] += 1
            path_counts[t] += 1
            path_counts[l] -= 1
            if parent[l] != -1:
                path_counts[parent[l]] -= 1

        def dfs_propagate_counts(u, p):
            for v in adj[u]:
                if v != p:
                    dfs_propagate_counts(v, u)
                    path_counts[u] += path_counts[v]

        dfs_propagate_counts(0, -1)

        def solve_dp(u, p):
            # Returns (cost_if_u_not_halved, cost_if_u_halved)

            cost_u_not_halved_base = prices[u] * path_counts[u]
            cost_u_halved_base = (prices[u] // 2) * path_counts[u]

            total_cost_not_halved = cost_u_not_halved_base
            total_cost_halved = cost_u_halved_base

            for v in adj[u]:
                if v != p:
                    child_dp_not_halved, child_dp_halved = solve_dp(v, u)

                    total_cost_not_halved += min(child_dp_not_halved, child_dp_halved)
                    total_cost_halved += child_dp_not_halved

            return total_cost_not_halved, total_cost_halved

        res0, res1 = solve_dp(0, -1)
        return min(res0, res1)