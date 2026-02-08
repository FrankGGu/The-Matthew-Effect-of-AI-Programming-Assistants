import heapq
from collections import defaultdict

class Solution:
    def countPaths(self, n: int, roads: List[List[int]]) -> int:
        graph = defaultdict(list)
        for u, v, time in roads:
            graph[u].append((v, time))
            graph[v].append((u, time))

        MOD = 10**9 + 7
        min_time = [float('inf')] * n
        ways = [0] * n
        min_time[0] = 0
        ways[0] = 1

        pq = [(0, 0)]  # (time, node)

        while pq:
            curr_time, node = heapq.heappop(pq)
            if curr_time > min_time[node]:
                continue
            for neighbor, travel_time in graph[node]:
                time = curr_time + travel_time
                if time < min_time[neighbor]:
                    min_time[neighbor] = time
                    ways[neighbor] = ways[node]
                    heapq.heappush(pq, (time, neighbor))
                elif time == min_time[neighbor]:
                    ways[neighbor] = (ways[neighbor] + ways[node]) % MOD

        return ways[n - 1]