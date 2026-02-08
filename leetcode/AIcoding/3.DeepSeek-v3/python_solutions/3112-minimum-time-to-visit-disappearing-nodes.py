import heapq

class Solution:
    def minimumTime(self, n: int, edges: List[List[int]], disappear: List[int]) -> List[int]:
        graph = [[] for _ in range(n)]
        for u, v, length in edges:
            graph[u].append((v, length))
            graph[v].append((u, length))

        dist = [float('inf')] * n
        dist[0] = 0
        heap = [(0, 0)]

        while heap:
            current_dist, u = heapq.heappop(heap)
            if current_dist > dist[u]:
                continue
            for v, length in graph[u]:
                if current_dist + length < disappear[v] and current_dist + length < dist[v]:
                    dist[v] = current_dist + length
                    heapq.heappush(heap, (dist[v], v))

        return [d if d != float('inf') else -1 for d in dist]