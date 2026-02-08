from collections import deque, defaultdict

class Solution:
    def collectTheCoins(self, coins: list[int], edges: list[list[int]]) -> int:
        n = len(coins)

        if n <= 1:
            return 0

        adj = defaultdict(list)
        degree = [0] * n

        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)
            degree[u] += 1
            degree[v] += 1

        q = deque()
        active_nodes = set(range(n))

        # Step 1: Initial Pruning - Remove all nodes that don't have coins and are not on any path to a coin.
        # This is done by repeatedly removing leaf nodes that do not have coins.
        for i in range(n):
            if coins[i] == 0 and degree[i] == 1:
                q.append(i)
                active_nodes.remove(i)
            elif degree[i] == 0: # Isolated node, remove it.
                active_nodes.remove(i)

        while q:
            u = q.popleft()
            for v in adj[u]:
                if v in active_nodes:
                    degree[v] -= 1
                    if degree[v] == 1 and coins[v] == 0:
                        q.append(v)
                        active_nodes.remove(v)

        # If after the first pruning, 1 or fewer nodes remain, no edges are needed.
        if len(active_nodes) <= 1:
            return 0

        # Step 2: Second Pruning - Remove the outermost two layers of leaves from the remaining tree.
        # This ensures that for every coin, there's a node in the final tree at most 2 steps away.

        # Re-calculate degrees for the active_nodes subgraph
        new_degree = [0] * n
        q_second_pruning = deque()

        for i in active_nodes:
            for j in adj[i]:
                if j in active_nodes:
                    new_degree[i] += 1
            if new_degree[i] == 1: # Current leaves of the active_nodes subgraph
                q_second_pruning.append(i)

        nodes_removed_in_2nd_pruning = set()

        # Perform two rounds of pruning
        for _ in range(2):
            num_nodes_in_current_round = len(q_second_pruning)
            if num_nodes_in_current_round == 0:
                break

            temp_q = deque()
            for _ in range(num_nodes_in_current_round):
                u = q_second_pruning.popleft()
                nodes_removed_in_2nd_pruning.add(u)
                temp_q.append(u)

            while temp_q:
                u = temp_q.popleft()
                for v in adj[u]:
                    if v in active_nodes and v not in nodes_removed_in_2nd_pruning:
                        new_degree[v] -= 1
                        if new_degree[v] == 1:
                            q_second_pruning.append(v)

        final_kept_node_count = len(active_nodes) - len(nodes_removed_in_2nd_pruning)

        kept_edges_count = max(0, final_kept_node_count - 1)

        return (n - 1) - kept_edges_count