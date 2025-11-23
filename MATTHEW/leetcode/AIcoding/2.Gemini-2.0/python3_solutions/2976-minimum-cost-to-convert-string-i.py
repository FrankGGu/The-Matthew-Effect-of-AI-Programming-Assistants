import heapq

class Solution:
    def minimumCost(self, source: str, target: str, original: list[str], changed: list[str], cost: list[int]) -> int:
        n = len(source)
        m = len(original)
        graph = {}
        for i in range(m):
            u = original[i]
            v = changed[i]
            w = cost[i]
            if u not in graph:
                graph[u] = []
            graph[u].append((v, w))

        def dijkstra(start):
            dist = {}
            for char in set(source + target + "".join(original) + "".join(changed)):
                dist[char] = float('inf')
            dist[start] = 0
            pq = [(0, start)]

            while pq:
                d, u = heapq.heappop(pq)
                if d > dist[u]:
                    continue

                if u in graph:
                    for v, w in graph[u]:
                        if dist[u] + w < dist[v]:
                            dist[v] = dist[u] + w
                            heapq.heappush(pq, (dist[v], v))
            return dist

        ans = 0
        for i in range(n):
            if source[i] == target[i]:
                continue

            dist = dijkstra(source[i])
            if dist[target[i]] == float('inf'):
                return -1
            ans += dist[target[i]]

        return ans