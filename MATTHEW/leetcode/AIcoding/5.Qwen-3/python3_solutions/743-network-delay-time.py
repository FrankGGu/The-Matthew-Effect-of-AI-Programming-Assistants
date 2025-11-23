import heapq

class Solution:
    def networkDelayTime(self, times: List[List[int]], n: int, k: int) -> int:
        graph = [[] for _ in range(n + 1)]
        for u, v, w in times:
            graph[u].append((v, w))

        dist = [float('inf')] * (n + 1)
        dist[k] = 0
        heap = [(0, k)]

        while heap:
            time, node = heapq.heappop(heap)
            if time > dist[node]:
                continue
            for neighbor, weight in graph[node]:
                if dist[neighbor] > dist[node] + weight:
                    dist[neighbor] = dist[node] + weight
                    heapq.heappush(heap, (dist[neighbor], neighbor))

        max_time = max(dist[1:])
        return max_time if max_time != float('inf') else -1