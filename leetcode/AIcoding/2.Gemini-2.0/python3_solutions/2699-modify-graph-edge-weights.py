import heapq

class Solution:
    def modifiedGraphEdges(self, n: int, edges: list[list[int]], source: int, destination: int, target: int) -> list[list[int]]:
        adj = [[] for _ in range(n)]
        unknown_edges = []
        for i, (u, v, w) in enumerate(edges):
            if w == -1:
                unknown_edges.append(i)
            adj[u].append((v, w, i))
            adj[v].append((u, w, i))

        def dijkstra(start, adj, edges):
            dist = [float('inf')] * n
            dist[start] = 0
            pq = [(0, start)]
            while pq:
                d, u = heapq.heappop(pq)
                if d > dist[u]:
                    continue
                for v, w, i in adj[u]:
                    if w == -1:
                        continue
                    if dist[u] + w < dist[v]:
                        dist[v] = dist[u] + w
                        heapq.heappush(pq, (dist[v], v))
            return dist

        dist_original = dijkstra(source, adj, edges)

        remaining = target - dist_original[destination]

        for i in unknown_edges:
            u, v, _ = edges[i]
            edges[i][2] = 1
            for node in adj[u]:
                if node[2] == i:
                    node = (node[0], 1, node[2])
            for node in adj[v]:
                if node[2] == i:
                    node = (node[0], 1, node[2])

        dist_updated = dijkstra(source, adj, edges)

        for i in unknown_edges:
            u, v, _ = edges[i]
            edges[i][2] = min(target - dist_updated[destination] + 1, 2 * 10**9)
            if edges[i][2] <= 0:
                return []
            for index in range(len(adj[u])):
                if adj[u][index][0] == v and adj[u][index][2] == i:
                    adj[u][index] = (v, edges[i][2], i)
            for index in range(len(adj[v])):
                if adj[v][index][0] == u and adj[v][index][2] == i:
                    adj[v][index] = (u, edges[i][2], i)

            dist_updated = dijkstra(source, adj, edges)

            if dist_updated[destination] > target:
                 edges[i][2] = 2*10**9
                 for index in range(len(adj[u])):
                     if adj[u][index][0] == v and adj[u][index][2] == i:
                         adj[u][index] = (v, edges[i][2], i)
                 for index in range(len(adj[v])):
                     if adj[v][index][0] == u and adj[v][index][2] == i:
                         adj[v][index] = (u, edges[i][2], i)

            else:

                for index in range(len(adj[u])):
                    if adj[u][index][0] == v and adj[u][index][2] == i:
                        adj[u][index] = (v, edges[i][2], i)
                for index in range(len(adj[v])):
                    if adj[v][index][0] == u and adj[v][index][2] == i:
                        adj[v][index] = (u, edges[i][2], i)

        dist_final = dijkstra(source, adj, edges)

        if dist_final[destination] != target:
            return []

        return edges