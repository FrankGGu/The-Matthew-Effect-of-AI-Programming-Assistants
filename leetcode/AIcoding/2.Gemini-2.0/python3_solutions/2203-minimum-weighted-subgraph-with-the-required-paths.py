import heapq

def minimumWeight(n, edges, src1, src2, dest):
    adj = [[] for _ in range(n)]
    radj = [[] for _ in range(n)]
    for u, v, w in edges:
        adj[u].append((v, w))
        radj[v].append((u, w))

    def dijkstra(start, graph):
        dist = [float('inf')] * n
        dist[start] = 0
        pq = [(0, start)]
        while pq:
            d, u = heapq.heappop(pq)
            if d > dist[u]:
                continue
            for v, w in graph[u]:
                if dist[v] > dist[u] + w:
                    dist[v] = dist[u] + w
                    heapq.heappush(pq, (dist[v], v))
        return dist

    dist1 = dijkstra(src1, adj)
    dist2 = dijkstra(src2, adj)
    dist_dest = dijkstra(dest, radj)

    ans = float('inf')
    for i in range(n):
        if dist1[i] != float('inf') and dist2[i] != float('inf') and dist_dest[i] != float('inf'):
            ans = min(ans, dist1[i] + dist2[i] + dist_dest[i])

    if ans == float('inf'):
        return -1
    return ans