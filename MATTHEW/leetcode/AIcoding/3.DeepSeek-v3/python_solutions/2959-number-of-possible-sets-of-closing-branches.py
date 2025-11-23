import heapq

class Solution:
    def numberOfSets(self, n: int, maxDistance: int, roads: List[List[int]]) -> int:
        graph = [[float('inf')] * n for _ in range(n)]
        for i in range(n):
            graph[i][i] = 0
        for u, v, w in roads:
            if graph[u][v] > w:
                graph[u][v] = w
                graph[v][u] = w

        res = 0
        for mask in range(1 << n):
            valid = True
            for i in range(n):
                if not (mask & (1 << i)):
                    continue
                dist = [float('inf')] * n
                dist[i] = 0
                heap = []
                heapq.heappush(heap, (0, i))
                while heap:
                    current_dist, u = heapq.heappop(heap)
                    if current_dist > dist[u]:
                        continue
                    for v in range(n):
                        if not (mask & (1 << v)):
                            continue
                        if graph[u][v] != float('inf') and dist[v] > dist[u] + graph[u][v]:
                            dist[v] = dist[u] + graph[u][v]
                            heapq.heappush(heap, (dist[v], v))
                for j in range(n):
                    if mask & (1 << j) and dist[j] > maxDistance:
                        valid = False
                        break
                if not valid:
                    break
            if valid:
                res += 1
        return res