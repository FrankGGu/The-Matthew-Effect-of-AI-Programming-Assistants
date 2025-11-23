import heapq

def minimumWeight(n: int, edges: list[list[int]], src1: int, src2: int, dest: int) -> int:
    adj = [[] for _ in range(n)]
    rev_adj = [[] for _ in range(n)]
    for u, v, w in edges:
        adj[u].append((v, w))
        rev_adj[v].append((u, w))

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
    dist_dest = dijkstra(dest, adj)
    dist_rev_dest = dijkstra(dest, rev_adj)

    ans = float('inf')
    for i in range(n):
        ans = min(ans, dist1[i] + dist2[i] + dist_rev_dest[i])

    if ans == float('inf'):
        return -1
    else:
        return ans