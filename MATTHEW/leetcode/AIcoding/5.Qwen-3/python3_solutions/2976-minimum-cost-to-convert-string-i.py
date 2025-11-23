class Solution:
    def minCost(self, source: str, target: str, original: str, changed: str, cost: int) -> int:
        import heapq

        from collections import defaultdict

        graph = defaultdict(dict)

        for o, c, co in zip(original, changed, cost):
            if c not in graph[o] or co < graph[o][c]:
                graph[o][c] = co

        def dijkstra(start):
            dist = {node: float('inf') for node in set(source + target)}
            dist[start] = 0
            heap = [(0, start)]
            while heap:
                d, node = heapq.heappop(heap)
                if d > dist[node]:
                    continue
                for neighbor, weight in graph[node].items():
                    if dist[neighbor] > d + weight:
                        dist[neighbor] = d + weight
                        heapq.heappush(heap, (dist[neighbor], neighbor))
            return dist

        result = 0
        dists = {}
        for char in set(source + target):
            dists[char] = dijkstra(char)

        for s, t in zip(source, target):
            if s == t:
                continue
            if t not in dists[s] or dists[s][t] == float('inf'):
                return -1
            result += dists[s][t]

        return result