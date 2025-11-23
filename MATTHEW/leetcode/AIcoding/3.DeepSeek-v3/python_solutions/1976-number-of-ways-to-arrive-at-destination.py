import heapq

class Solution:
    def countPaths(self, n: int, roads: List[List[int]]) -> int:
        MOD = 10**9 + 7
        graph = [[] for _ in range(n)]
        for u, v, time in roads:
            graph[u].append((v, time))
            graph[v].append((u, time))

        dist = [float('inf')] * n
        ways = [0] * n
        dist[0] = 0
        ways[0] = 1
        heap = [(0, 0)]

        while heap:
            current_dist, u = heapq.heappop(heap)
            if current_dist > dist[u]:
                continue
            for v, time in graph[u]:
                if dist[v] > current_dist + time:
                    dist[v] = current_dist + time
                    ways[v] = ways[u]
                    heapq.heappush(heap, (dist[v], v))
                elif dist[v] == current_dist + time:
                    ways[v] = (ways[v] + ways[u]) % MOD

        return ways[n - 1] % MOD