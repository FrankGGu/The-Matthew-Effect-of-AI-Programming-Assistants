import heapq
import math

class Solution:
    def minCost(self, n: int, roads: list[list[int]], charging_stations: list[int], start: int, end: int, max_battery: int) -> int:
        adj = [[] for _ in range(n)]
        for u, v, dist_val, battery_cost in roads:
            adj[u].append((v, dist_val, battery_cost))
            adj[v].append((u, dist_val, battery_cost))

        is_charging_station = [False] * n
        for station_id in charging_stations:
            is_charging_station[station_id] = True

        dist = [[math.inf] * (max_battery + 1) for _ in range(n)]

        pq = [(0, start, max_battery)]
        dist[start][max_battery] = 0

        while pq:
            d, u, b = heapq.heappop(pq)

            if d > dist[u][b]:
                continue

            if is_charging_station[u]:
                if d < dist[u][max_battery]:
                    dist[u][max_battery] = d
                    heapq.heappush(pq, (d, u, max_battery))

            for v, dist_uv, battery_cost_uv in adj[u]:
                if b >= battery_cost_uv:
                    new_b = b - battery_cost_uv
                    new_d = d + dist_uv
                    if new_d < dist[v][new_b]:
                        dist[v][new_b] = new_d
                        heapq.heappush(pq, (new_d, v, new_b))

        min_total_dist = math.inf
        for battery_level in range(max_battery + 1):
            min_total_dist = min(min_total_dist, dist[end][battery_level])

        return min_total_dist if min_total_dist != math.inf else -1