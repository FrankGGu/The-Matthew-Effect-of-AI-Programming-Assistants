import heapq

class Solution:
    def minCost(self, maxTime: int, edges: List[List[int]], passingFees: List[int]) -> int:
        n = len(passingFees)
        graph = [[] for _ in range(n)]
        for u, v, t in edges:
            graph[u].append((v, t))
            graph[v].append((u, t))

        heap = []
        heapq.heappush(heap, (passingFees[0], 0, 0))

        cost = [float('inf')] * n
        time = [float('inf')] * n
        cost[0] = passingFees[0]
        time[0] = 0

        while heap:
            current_cost, current_time, u = heapq.heappop(heap)
            if u == n - 1:
                return current_cost
            for v, t in graph[u]:
                new_time = current_time + t
                new_cost = current_cost + passingFees[v]
                if new_time <= maxTime and (new_cost < cost[v] or new_time < time[v]):
                    if new_cost < cost[v] or new_time < time[v]:
                        cost[v] = min(cost[v], new_cost)
                        time[v] = min(time[v], new_time)
                        heapq.heappush(heap, (new_cost, new_time, v))

        return -1