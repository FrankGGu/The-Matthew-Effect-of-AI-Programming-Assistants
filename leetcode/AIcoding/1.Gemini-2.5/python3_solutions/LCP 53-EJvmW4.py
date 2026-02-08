from collections import deque

class Solution:
    def guardTheSpaceCity(self, m: int, n: int, grid: list[list[int]], guards: list[list[int]]) -> int:
        # Construct the bipartite graph for maximum matching.
        # By Konig's Theorem, minimum vertex cover in a bipartite graph
        # is equal to the maximum matching.
        # We model this as a maximum flow problem using Dinic's algorithm.

        # Node mapping:
        # Source S = 0
        # Rows 0 to m-1 are mapped to graph nodes 1 to m.
        # Columns 0 to n-1 are mapped to graph nodes m+1 to m+n.
        # Sink T = m + n + 1

        num_nodes = m + n + 2
        S = 0
        T = num_nodes - 1

        # Adjacency list for the flow network.
        # Each edge stores [to_node, capacity, reverse_edge_index].
        adj = [[] for _ in range(num_nodes)]

        def add_edge(u, v, cap):
            adj[u].append([v, cap, len(adj[v])])
            adj[v].append([u, 0, len(adj[u]) - 1]) # Residual edge for reverse flow

        # Add edges from Source to all row nodes with capacity 1.
        for i in range(m):
            add_edge(S, i + 1, 1) # Row i (0-indexed) maps to node i+1

        # Add edges from all column nodes to Sink with capacity 1.
        for j in range(n):
            add_edge(m + j + 1, T, 1) # Column j (0-indexed) maps to node m+j+1

        # Add edges from row nodes to column nodes for each special cell.
        # A special cell (r, c) means we need to cover row r OR column c.
        # This corresponds to an edge between row node r and column node c.
        for r, c in guards:
            # Row r (0-indexed) maps to node r+1
            # Column c (0-indexed) maps to node m+c+1
            add_edge(r + 1, m + c + 1, 1)

        # Dinic's Algorithm implementation:
        level = [-1] * num_nodes # Stores level of each node in the layered network
        ptr = [0] * num_nodes    # Used to optimize DFS by avoiding re-exploring dead-end edges

        # BFS to build the layered network and determine if T is reachable from S.
        def bfs():
            nonlocal level
            level = [-1] * num_nodes
            level[S] = 0
            q = deque([S])
            while q:
                u = q.popleft()
                for v, cap, _ in adj[u]:
                    if cap > 0 and level[v] == -1:
                        level[v] = level[u] + 1
                        q.append(v)
            return level[T] != -1 # Return True if T is reachable

        # DFS to find augmenting paths in the layered network and push flow.
        def dfs(u, pushed):
            if pushed == 0:
                return 0
            if u == T:
                return pushed

            # Iterate through edges from u using ptr to avoid redundant checks.
            while ptr[u] < len(adj[u]):
                v, cap, rev = adj[u][ptr[u]]
                # Check if v is in the next layer and has capacity.
                if level[v] != level[u] + 1 or cap == 0:
                    ptr[u] += 1
                    continue

                # Recursively find flow from v.
                tr = dfs(v, min(pushed, cap))
                if tr == 0: # If no flow found from v, try next edge.
                    ptr[u] += 1
                    continue

                # Update capacities.
                adj[u][ptr[u]][1] -= tr # Reduce forward edge capacity
                adj[v][rev][1] += tr    # Increase reverse edge capacity (residual graph)
                return tr # Return flow pushed
            return 0 # No augmenting path found from u

        max_flow = 0
        # Repeatedly build layered network and find augmenting paths until T is unreachable.
        while bfs():
            ptr = [0] * num_nodes # Reset ptr for each new BFS phase (layered network)
            while True:
                pushed = dfs(S, float('inf')) # Find an augmenting path from S
                if pushed == 0: # If no more augmenting paths in current layered network, break.
                    break
                max_flow += pushed # Accumulate total flow

        return max_flow