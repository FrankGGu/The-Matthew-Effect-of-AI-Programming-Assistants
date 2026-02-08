import heapq

def networkDelayTime(times, n, k):
    graph = {}
    for u, v, w in times:
        if u not in graph:
            graph[u] = []
        graph[u].append((v, w))

    dist = {node: float('inf') for node in range(1, n + 1)}
    dist[k] = 0

    pq = [(0, k)]
    while pq:
        d, u = heapq.heappop(pq)

        if d > dist[u]:
            continue

        if u in graph:
            for v, w in graph[u]:
                if dist[v] > dist[u] + w:
                    dist[v] = dist[u] + w
                    heapq.heappush(pq, (dist[v], v))

    max_delay = max(dist.values())
    return max_delay if max_delay != float('inf') else -1