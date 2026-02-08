class Solution:
    def shortestDistanceAfterRoadAddition(self, n: int, m: int, roads: list[list[int]], queries: list[list[int]]) -> list[int]:
        # A value larger than any possible shortest path (N * max_weight = 200 * 10^9 = 2 * 10^11)
        # Using a large integer for INF as the problem expects integer output.
        INF = 5 * 10**11 

        dist = [[INF] * n for _ in range(n)]

        for i in range(n):
            dist[i][i] = 0

        # Process initial roads
        for u, v, w in roads:
            u -= 1
            v -= 1
            dist[u][v] = min(dist[u][v], w)
            dist[v][u] = min(dist[v][u], w)

        # Floyd-Warshall for initial graph
        for k in range(n):
            for i in range(n):
                for j in range(n):
                    # Only update if intermediate paths are reachable
                    if dist[i][k] != INF and dist[k][j] != INF:
                        dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])

        current_total_sum = 0
        for i in range(n):
            for j in range(n):
                # Sum all pairs (i, j) where i != j. This sum will be twice the required sum (for i < j).
                if i != j:
                    current_total_sum += dist[i][j]

        results = []
        results.append(current_total_sum // 2)

        # Process queries
        for u_q, v_q, w_q in queries:
            u_idx = u_q - 1
            v_idx = v_q - 1

            # Optimization: Only proceed if the new road potentially shortens any path.
            # A new road (u_idx, v_idx) with weight w_q can shorten paths
            # only if w_q is less than the current shortest path between u_idx and v_idx.
            # If w_q is not shorter than dist[u_idx][v_idx], then any path using
            # this new road (e.g., i -> ... -> u_idx -> v_idx -> ... -> j) will not be shorter
            # than existing paths, because a path i -> ... -> u_idx -> (existing shortest path) -> v_idx -> ... -> j
            # already exists and is no longer than the path using the new road.
            if w_q < dist[u_idx][v_idx]:
                change_for_this_query = 0

                # Update all-pairs shortest paths using the new road (u_idx, v_idx) with weight w_q.
                # For every pair (i, j), the shortest path can now potentially use the new road.
                # Path options:
                # 1. Existing shortest path: dist[i][j]
                # 2. Path via new road: i -> ... -> u_idx -> v_idx -> ... -> j
                # 3. Path via new road (reversed): i -> ... -> v_idx -> u_idx -> ... -> j (for undirected graph)
                for i in range(n):
                    for j in range(n):
                        old_val = dist[i][j]

                        # Calculate path i -> ... -> u_idx -> (new edge w_q) -> v_idx -> ... -> j
                        path1_val = INF
                        if dist[i][u_idx] != INF and dist[v_idx][j] != INF:
                            path1_val = dist[i][u_idx] + w_q + dist[v_idx][j]

                        # Calculate path i -> ... -> v_idx -> (new edge w_q) -> u_idx -> ... -> j
                        # (This is for undirected graph where new road can be traversed v_idx -> u_idx)
                        path2_val = INF
                        if dist[i][v_idx] != INF and dist[u_idx][j] != INF:
                            path2_val = dist[i][v_idx] + w_q + dist[u_idx][j]

                        dist[i][j] = min(dist[i][j], path1_val, path2_val)

                        # Accumulate the total reduction in shortest path distances
                        if dist[i][j] < old_val:
                            change_for_this_query += (old_val - dist[i][j])

                current_total_sum -= change_for_this_query

            results.append(current_total_sum // 2)

        return results