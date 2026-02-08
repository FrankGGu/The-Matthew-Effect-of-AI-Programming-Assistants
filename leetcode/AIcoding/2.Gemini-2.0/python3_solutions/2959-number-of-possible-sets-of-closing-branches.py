class Solution:
    def numberOfSets(self, n: int, maxDistance: int, roads: List[List[int]]) -> int:
        adj = [[] for _ in range(n)]
        for u, v, w in roads:
            adj[u].append((v, w))
            adj[v].append((u, w))

        def dijkstra(nodes):
            dist = [float('inf')] * n
            for node in nodes:
                dist[node] = 0

            import heapq
            pq = [(0, node) for node in nodes]
            heapq.heapify(pq)

            while pq:
                d, u = heapq.heappop(pq)
                if d > dist[u]:
                    continue

                for v, w in adj[u]:
                    if dist[v] > dist[u] + w:
                        dist[v] = dist[u] + w
                        heapq.heappush(pq, (dist[v], v))
            return dist

        count = 0
        for i in range(1 << n):
            nodes = []
            for j in range(n):
                if (i >> j) & 1:
                    nodes.append(j)

            if not nodes:
                count += 1
                continue

            dist = dijkstra(nodes)

            valid = True
            for node in nodes:
                if dist[node] > maxDistance:
                    valid = False
                    break

            if valid:
                count += 1

        return count