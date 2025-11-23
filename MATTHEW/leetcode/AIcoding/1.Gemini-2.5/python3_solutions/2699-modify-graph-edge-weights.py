import heapq

class Solution:
    def modifyGraphEdgeWeights(self, n: int, edges: list[list[int]], source: int, destination: int, target: int) -> list[list[int]]:
        adj = [[] for _ in range(n)]
        for i, (u, v, w) in enumerate(edges):
            adj[u].append((v, w, i))
            adj[v].append((u, w, i)) # Assuming undirected graph as per typical LeetCode behavior unless specified

        modified_edges = [list(edge) for edge in edges]

        def dijkstra(start_node, current_edges_weights):
            dist = [float('inf')] * n
            pq = [(0, start_node)]
            dist[start_node] = 0

            while pq:
                d, u = heapq.heappop(pq)

                if d > dist[u]:
                    continue

                for v, _, edge_idx in adj[u]:
                    weight = current_edges_weights[edge_idx][2]
                    if dist[u] + weight < dist[v]:
                        dist[v] = dist[u] + weight
                        heapq.heappush(pq, (dist[v], v))
            return dist

        # Phase 1: Calculate shortest path from source to all nodes,
        # treating all -1 edges as having weight 1.
        # This helps determine the minimum possible shortest path.
        temp_edges_for_dijkstra = [list(edge) for edge in edges]
        for i in range(len(temp_edges_for_dijkstra)):
            if temp_edges_for_dijkstra[i][2] == -1:
                temp_edges_for_dijkstra[i][2] = 1

        dist_from_source_with_ones = dijkstra(source, temp_edges_for_dijkstra)

        # If destination is unreachable even with -1s as 1, it's impossible to reach target.
        if dist_from_source_with_ones[destination] == float('inf'):
            return []

        # Case 1: Shortest path with all -1s as 1 is already greater than target.
        # Impossible, as we can only increase weights of -1 edges, not decrease.
        if dist_from_source_with_ones[destination] > target:
            return []

        # Case 2: Shortest path with all -1s as 1 is exactly target.
        # This is a valid solution. Ensure all original -1 edges are set to 1.
        if dist_from_source_with_ones[destination] == target:
            for i in range(len(modified_edges)):
                if modified_edges[i][2] == -1:
                    modified_edges[i][2] = 1
            return modified_edges

        # Case 3: Shortest path with all -1s as 1 is less than target.
        # We need to increase the path length by `target - dist_from_source_with_ones[destination]`.
        # We achieve this by finding an original -1 edge, increasing its weight,
        # and checking if that makes the shortest path exactly `target`.

        # Initialize all original -1 edges in `modified_edges` to 1 as a base.
        for i in range(len(modified_edges)):
            if modified_edges[i][2] == -1:
                modified_edges[i][2] = 1

        # To find which -1 edge to adjust, we need shortest paths from `source` to `u`
        # and from `v` to `destination` (on the graph where all -1s are 1).
        # `dist_from_source_with_ones` already gives `dist(source, u)`.
        # We need `dist(v, destination)`. This is `dist_from_dest_with_ones[v]`
        # calculated by running Dijkstra from `destination`.
        dist_from_dest_with_ones = dijkstra(destination, temp_edges_for_dijkstra)

        found_solution = False
        for i in range(len(edges)):
            u_orig, v_orig, w_orig = edges[i]
            if w_orig == -1:
                # If this edge (u_orig, v_orig) is part of a path from source to destination,
                # the path length would be `dist(source, u_orig) + weight_of_this_edge + dist(v_orig, destination)`.
                # We want this to be `target`.
                # So, `weight_of_this_edge = target - dist(source, u_orig) - dist(v_orig, destination)`.

                # Ensure paths to u_orig and from v_orig are reachable.
                if dist_from_source_with_ones[u_orig] != float('inf') and dist_from_dest_with_ones[v_orig] != float('inf'):
                    required_weight_for_this_edge = target - dist_from_source_with_ones[u_orig] - dist_from_dest_with_ones[v_orig]

                    # The required weight must be at least 1 (as it's a positive integer).
                    # Also, it must be greater than or equal to the current weight (1) if it's an original -1 edge.
                    if required_weight_for_this_edge >= 1:
                        # Temporarily set this edge's weight in `modified_edges`.
                        # All other original -1 edges are still 1.
                        modified_edges[i][2] = required_weight_for_this_edge

                        # Run Dijkstra with this new set of weights to verify if the shortest path is exactly `target`.
                        current_shortest_path_to_dest = dijkstra(source, modified_edges)[destination]

                        if current_shortest_path_to_dest == target:
                            found_solution = True
                            break # Found a valid assignment for -1 edges

                        # If this specific assignment didn't work, revert this edge's weight for the next iteration.
                        modified_edges[i][2] = 1 

        if found_solution:
            return modified_edges
        else:
            # If no single -1 edge adjustment (while others are 1) leads to target, it's impossible.
            return []