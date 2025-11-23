import heapq
from collections import defaultdict

class Solution:
    def findAnswer(self, n: int, edges: List[List[int]]) -> List[bool]:
        graph = defaultdict(list)
        for i, (u, v, w) in enumerate(edges):
            graph[u].append((v, w, i))
            graph[v].append((u, w, i))

        def dijkstra(start):
            dist = [float('inf')] * n
            dist[start] = 0
            heap = [(0, start)]
            while heap:
                current_dist, u = heapq.heappop(heap)
                if current_dist > dist[u]:
                    continue
                for v, w, _ in graph[u]:
                    if dist[v] > dist[u] + w:
                        dist[v] = dist[u] + w
                        heapq.heappush(heap, (dist[v], v))
            return dist

        dist0 = dijkstra(0)
        dist1 = dijkstra(n - 1)
        total_shortest = dist0[n - 1]

        answer = [False] * len(edges)
        if total_shortest == float('inf'):
            return answer

        for u, v, w, idx in [(u, v, w, i) for i, (u, v, w) in enumerate(edges)]:
            if dist0[u] + w + dist1[v] == total_shortest or dist0[v] + w + dist1[u] == total_shortest:
                answer[idx] = True
        return answer