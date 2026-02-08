import math

class Solution:
    def numberOfSets(self, n: int, maxDistance: int, roads: list[list[int]]) -> int:
        INF = math.inf

        # Step 1: Initialize distance matrix for all pairs
        # dist[i][j] will store the shortest path between branch i and branch j
        dist = [[INF] * n for _ in range(n)]

        # Initialize distances for direct roads and self-loops
        for i in range(n):
            dist[i][i] = 0

        for u, v, w in roads:
            # Adjust to 0-indexed branches
            u -= 1
            v -= 1
            dist[u][v] = min(dist[u][v], w)
            dist[v][u] = min(dist[v][u], w)

        # Step 2: Apply Floyd-Warshall algorithm to find all-pairs shortest paths
        # This computes shortest paths considering all branches as intermediate nodes
        for k in range(n):
            for i in range(n):
                for j in range(n):
                    if dist[i][k] != INF and dist[k][j] != INF:
                        dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])

        valid_sets_count = 0

        # Step 3: Iterate through all possible subsets of branches to keep open
        # A bitmask represents the subset of open branches
        # (1 << n) generates 2^n, so loop from 0 to 2^n - 1
        for mask in range(1 << n):
            current_max_dist = 0
            is_valid_set = True

            # Extract indices of branches that are open in the current mask
            open_branches_indices = [i for i in range(n) if (mask >> i) & 1]

            # If there are 0 or 1 open branches, the max distance is 0, which is always valid
            if len(open_branches_indices) <= 1:
                valid_sets_count += 1
                continue

            # Check all pairs of distinct open branches
            for p1_idx in range(len(open_branches_indices)):
                for p2_idx in range(p1_idx + 1, len(open_branches_indices)):
                    b1 = open_branches_indices[p1_idx]
                    b2 = open_branches_indices[p2_idx]

                    # If two open branches are disconnected, the set is invalid
                    if dist[b1][b2] == INF:
                        is_valid_set = False
                        break # Exit inner loop

                    # Update the maximum distance found in this set
                    current_max_dist = max(current_max_dist, dist[b1][b2])

                if not is_valid_set:
                    break # Exit outer loop if set is already invalid

            # If the set is valid and its maximum distance is within maxDistance, increment count
            if is_valid_set and current_max_dist <= maxDistance:
                valid_sets_count += 1

        return valid_sets_count