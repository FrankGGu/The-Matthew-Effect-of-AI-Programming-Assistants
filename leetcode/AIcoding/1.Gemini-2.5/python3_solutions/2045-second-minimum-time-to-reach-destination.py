import collections
import heapq

class Solution:
    def secondMinimum(self, n: int, edges: list[list[int]], time: int, change: int) -> int:
        graph = collections.defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        # dist[node][0] stores the first minimum time to reach node
        # dist[node][1] stores the second minimum time to reach node
        dist = [[float('inf')] * 2 for _ in range(n + 1)]

        # Priority queue stores (current_total_time, node)
        pq = [(0, 1)] # Start at node 1 with time 0
        dist[1][0] = 0

        while pq:
            current_time, u = heapq.heappop(pq)

            # If we've already found two distinct minimum times for 'u'
            # and the current path 'current_time' is greater than or equal to the second minimum,
            # then this path is not useful for finding shorter paths.
            # This optimization prunes redundant paths.
            if current_time > dist[u][1]:
                continue

            # If we reached the destination node 'n' and this 'current_time'
            # is the second minimum time recorded for 'n', then we found our answer.
            # Since it's a min-heap, this is guaranteed to be the actual second minimum.
            if u == n and current_time == dist[n][1]:
                return current_time

            # Calculate actual arrival time at 'u' considering traffic lights
            # 'num_cycles' is the number of 'change' intervals passed
            num_cycles = current_time // change

            # If 'num_cycles' is odd, it means the light is red.
            # We must wait until the light turns green.
            if num_cycles % 2 == 1:
                # Time to wait until the next green light starts
                actual_arrival_time_at_u = (num_cycles + 1) * change
            else:
                # Light is green, no waiting needed.
                actual_arrival_time_at_u = current_time

            # Time to reach a neighbor 'v' from 'u'
            time_to_reach_neighbor = actual_arrival_time_at_u + time

            for v in graph[u]:
                # Case 1: Found a new shortest path to 'v'
                if time_to_reach_neighbor < dist[v][0]:
                    dist[v][1] = dist[v][0]  # Old first becomes new second
                    dist[v][0] = time_to_reach_neighbor # New first
                    heapq.heappush(pq, (time_to_reach_neighbor, v))
                # Case 2: Found a new second shortest path to 'v'
                # It must be strictly greater than the first shortest path
                # and strictly less than the current second shortest path.
                elif time_to_reach_neighbor > dist[v][0] and time_to_reach_neighbor < dist[v][1]:
                    dist[v][1] = time_to_reach_neighbor # New second
                    heapq.heappush(pq, (time_to_reach_neighbor, v))

        # This line should theoretically not be reached if a second minimum path always exists
        # as per typical LeetCode problem constraints where a solution is guaranteed.
        # However, it's good practice for robustness.
        return -1