import sys

class Solution:
    def minOperationsQueries(self, n: int, edges: list[list[int]], queries: list[list[int]]) -> list[int]:
        # Set recursion limit for deep trees
        sys.setrecursionlimit(n + 100) # A bit more than N to be safe

        adj = [[] for _ in range(n)]
        for u, v, w in edges:
            adj[u].append((v, w))
            adj[v].append((u, w))

        # max_log_depth is ceil(log2(n))
        # It determines the maximum power of 2 for ancestors (2^0, 2^1, ..., 2^(max_log_depth-1))
        max_log_depth = (n - 1).bit_length() if n > 1 else 1

        depth = [-1] * n
        # parent[i][k] stores the 2^k-th ancestor of node i
        parent = [[-1] * max_log_depth for _ in range(n)]

        # prefix_counts[i][w] stores the count of edges with weight 'w' on the path from root to node 'i'
        # Weights are 1 to 26, so index 0 is unused, 1-26 are for weights.
        prefix_counts = [[0] * 27 for _ in range(n)]

        # DFS to precompute depth, parent[i][0], and prefix_counts
        def dfs(u, p, d, edge_weight_to_u):
            depth[u] = d
            parent[u][0] = p

            if p != -1:
                # Copy prefix counts from parent
                for w_idx in range(1, 27):
                    prefix_counts[u][w_idx] = prefix_counts[p][w_idx]
                # Increment count for the edge leading to u
                prefix_counts[u][edge_weight_to_u] += 1
            # If u is root (p == -1), prefix_counts[u] remains all zeros, which is correct.

            for v, w in adj[u]:
                if v != p:
                    dfs(v, u, d + 1, w)

        # Start DFS from root node 0. Root has depth 0, no incoming edge weight from a parent.
        dfs(0, -1, 0, -1) 

        # Fill parent[i][k] for k > 0 using binary lifting
        for k in range(1, max_log_depth):
            for i in range(n):
                if parent[i][k-1] != -1:
                    parent[i][k] = parent[parent[i][k-1]][k-1]

        # Function to find LCA of two nodes u and v
        def get_lca(u, v):
            # Bring u and v to the same depth
            if depth[u] < depth[v]:
                u, v = v, u # Swap to ensure u is deeper or at same depth

            # Lift u up by powers of 2 until its depth matches v's depth
            for k in range(max_log_depth - 1, -1, -1):
                if parent[u][k] != -1 and depth[parent[u][k]] >= depth[v]:
                    u = parent[u][k]

            if u == v:
                return u

            # Lift u and v simultaneously until their parents are the same
            for k in range(max_log_depth - 1, -1, -1):
                if parent[u][k] != -1 and parent[v][k] != -1 and parent[u][k] != parent[v][k]:
                    u = parent[u][k]
                    v = parent[v][k]

            # The parent of u (or v) is the LCA
            return parent[u][0]

        results = []
        for u, v in queries:
            lca_node = get_lca(u, v)

            # Total edges on path u -> v
            # The path from u to v goes through LCA.
            # Edges(u, v) = Edges(root, u) + Edges(root, v) - 2 * Edges(root, LCA)
            total_edges_on_path = depth[u] + depth[v] - 2 * depth[lca_node]

            min_cost = float('inf')

            # Iterate through all possible target weights (1 to 26)
            for target_weight in range(1, 27):
                # Count of edges with target_weight on path u -> v
                # This is calculated similarly to total_edges_on_path
                count_target_weight = (prefix_counts[u][target_weight] + 
                                       prefix_counts[v][target_weight] - 
                                       2 * prefix_counts[lca_node][target_weight])

                # Cost for this target_weight: total edges - count of target_weight edges
                # This represents the number of edges that are NOT the target_weight
                cost = total_edges_on_path - count_target_weight
                min_cost = min(min_cost, cost)

            results.append(min_cost)

        return results