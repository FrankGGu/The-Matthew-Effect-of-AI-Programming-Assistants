import heapq

def countOfPairs(n, m, roads):
    adj = [[] for _ in range(n + 1)]
    for u, v, w in roads:
        adj[u].append((v, w))
        adj[v].append((u, w))

    def dijkstra(start):
        dist = [float('inf')] * (n + 1)
        dist[start] = 0
        pq = [(0, start)]
        while pq:
            d, u = heapq.heappop(pq)
            if d > dist[u]:
                continue
            for v, w in adj[u]:
                if dist[v] > dist[u] + w:
                    dist[v] = dist[u] + w
                    heapq.heappush(pq, (dist[v], v))
        return dist

    counts = {}
    for i in range(1, n + 1):
        dists = dijkstra(i)
        for j in range(i + 1, n + 1):
            distance = dists[j]
            if distance != float('inf'):
                counts[distance] = counts.get(distance, 0) + 2

    ans = [0] * n
    for distance, count in counts.items():
        if distance <= n:
            ans[distance - 1] = count
    return ans