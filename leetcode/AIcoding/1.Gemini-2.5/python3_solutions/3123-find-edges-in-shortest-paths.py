import heapq
import math

class Solution:
    def findShortestPaths(self, n: int, edges: list[list[int]]) -> list[int]:
        adj = [[] for _ in range(n)]
        # Build adjacency list for an undirected graph
        # Each entry is (neighbor_node, weight)
        for u, v, w in edges:
            adj[u].append((v, w))
            adj[v].append((u, w))

        def dijkstra(start_node: int) -> list[int]:
            dist = [math.inf] * n
            dist[start_node] = 0
            # Min-priority queue stores (current_distance, node)
            pq = [(0, start_node)] 

            while pq:
                d, u = heapq.heappop(pq)

                # If we found a shorter path to u already, skip
                if d > dist[u]:
                    continue

                # Explore neighbors
                for v, weight in adj[u]:
                    if dist[u] + weight < dist[v]:
                        dist[v] = dist[u] + weight
                        heapq.heappush(pq, (dist[v], v))
            return dist

        # Run Dijkstra from source node 0
        dist_from_src = dijkstra(0)
        # Run Dijkstra from target node n-1
        # Since the graph is undirected, dist_from_target[v] is the shortest path from v to n-1
        dist_from_target = dijkstra(n - 1)

        # The overall shortest path length from 0 to n-1
        shortest_path_len = dist_from_src[n - 1]

        result_indices = []

        # If there's no path from 0 to n-1, no edge can be part of a shortest path
        if shortest_path_len == math.inf:
            return []

        # Iterate through all original edges to check if they are part of any shortest path
        for i, (u, v, w) in enumerate(edges):
            # An edge (u, v) with weight w is part of a shortest path from 0 to n-1
            # if the path 0 -> ... -> u -> v -> ... -> n-1 has total length equal to shortest_path_len
            # OR the path 0 -> ... -> v -> u -> ... -> n-1 has total length equal to shortest_path_len.

            # Check path via u -> v
            # dist_from_src[u] is d(0, u)
            # dist_from_target[v] is d(v, n-1)
            condition1 = (dist_from_src[u] + w + dist_from_target[v] == shortest_path_len)

            # Check path via v -> u (since graph is undirected)
            # dist_from_src[v] is d(0, v)
            # dist_from_target[u] is d(u, n-1)
            condition2 = (dist_from_src[v] + w + dist_from_target[u] == shortest_path_len)

            if condition1 or condition2:
                result_indices.append(i)

        return result_indices