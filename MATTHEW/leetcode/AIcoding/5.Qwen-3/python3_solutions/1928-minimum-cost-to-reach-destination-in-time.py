from typing import List
import heapq

class Solution:
    def minCostToReachDestination(self, n: int, roads: List[List[int]], traps: List[int], time: List[int], cost: List[int]) -> int:
        graph = [[] for _ in range(n)]
        for road in roads:
            u, v, w = road
            graph[u].append((v, w))
            graph[v].append((u, w))

        trap_set = set(traps)
        dist = [float('inf')] * n
        dist[0] = 0
        heap = [(0, 0)]

        while heap:
            curr_cost, u = heapq.heappop(heap)
            if u == n - 1:
                return curr_cost
            if curr_cost > dist[u]:
                continue
            for v, w in graph[u]:
                new_cost = curr_cost + w
                if u in trap_set or v in trap_set:
                    new_cost += cost[u]
                if new_cost < dist[v]:
                    dist[v] = new_cost
                    heapq.heappush(heap, (new_cost, v))

        return dist[n-1]