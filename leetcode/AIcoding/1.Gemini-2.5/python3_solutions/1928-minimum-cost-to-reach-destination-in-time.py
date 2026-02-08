import heapq
import sys
from collections import defaultdict

class Solution:
    def minCost(self, max_time: int, edges: list[list[int]], fees: list[int]) -> int:
        n = len(fees)

        min_fee_to_reach = [[sys.maxsize] * (max_time + 1) for _ in range(n)]

        adj = defaultdict(list)
        for u, v, travel_time, travel_fee in edges:
            adj[u].append((v, travel_time, travel_fee))
            adj[v].append((u, travel_time, travel_fee))

        pq = [(fees[0], 0, 0)]  # (current_fee, current_time, current_city)
        min_fee_to_reach[0][0] = fees[0]

        while pq:
            current_fee, current_time, u = heapq.heappop(pq)

            if current_fee > min_fee_to_reach[u][current_time]:
                continue

            for v, travel_time, travel_fee in adj[u]:
                new_time = current_time + travel_time

                if new_time > max_time:
                    continue

                new_fee = current_fee + travel_fee + fees[v]

                if new_fee < min_fee_to_reach[v][new_time]:
                    min_fee_to_reach[v][new_time] = new_fee
                    heapq.heappush(pq, (new_fee, new_time, v))

        min_total_cost = sys.maxsize
        for t in range(max_time + 1):
            min_total_cost = min(min_total_cost, min_fee_to_reach[n-1][t])

        return min_total_cost if min_total_cost != sys.maxsize else -1