import heapq

class Solution:
    def minimumTime(self, n: int, edges: list[list[int]], disappear: list[int]) -> list[int]:
        adj = [[] for _ in range(n)]
        for u, v, length in edges:
            adj[u].append((v, length))
            adj[v].append((u, length))

        dist = [float('inf')] * n

        min_heap = []

        # According to the problem statement, "you can visit node i only if you reach it strictly before its disappear time disappear[i]".
        # For the starting node 0 at time 0:
        # If disappear[0] > 0, we can visit node 0 at time 0.
        # If disappear[0] <= 0, we cannot visit node 0 at time 0, so it's initially unreachable.
        if disappear[0] > 0:
            dist[0] = 0
            heapq.heappush(min_heap, (0, 0)) # (time, node)

        while min_heap:
            current_time, u = heapq.heappop(min_heap)

            # If we found a shorter path to u already, skip this one.
            if current_time > dist[u]:
                continue

            for v, length in adj[u]:
                arrival_time = current_time + length

                # Check if node v is still available at the calculated arrival_time.
                # It must be strictly before its disappear time.
                if arrival_time < disappear[v]:
                    if arrival_time < dist[v]:
                        dist[v] = arrival_time
                        heapq.heappush(min_heap, (arrival_time, v))

        # Convert unreachable nodes (still float('inf')) to -1.
        for i in range(n):
            if dist[i] == float('inf'):
                dist[i] = -1

        return dist