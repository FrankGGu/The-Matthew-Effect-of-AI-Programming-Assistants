import heapq

def minCostWalk(n: int, edges: list[list[int]], start: int, target: int, k: int) -> int:
    graph = [[] for _ in range(n)]
    for u, v, w in edges:
        graph[u].append((v, w))

    dist = [[float('inf')] * (k + 1) for _ in range(n)]
    dist[start][0] = 0
    pq = [(0, start, 0)]

    while pq:
        d, u, steps = heapq.heappop(pq)

        if d > dist[u][steps]:
            continue

        if u == target and steps == k:
            return d

        if steps < k:
            for v, w in graph[u]:
                if dist[v][steps + 1] > d + w:
                    dist[v][steps + 1] = d + w
                    heapq.heappush(pq, (d + w, v, steps + 1))

    return -1