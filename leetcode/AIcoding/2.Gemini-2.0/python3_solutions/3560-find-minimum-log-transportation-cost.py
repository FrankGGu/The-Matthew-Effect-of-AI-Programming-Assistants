import heapq

def minCost(n: int, roads: list[list[int]], expectedCost: list[list[int]]) -> int:
    adj = [[] for _ in range(n + 1)]
    for u, v, w in roads:
        adj[u].append((v, w))
        adj[v].append((u, w))

    adj_exp = [[] for _ in range(n + 1)]
    for u, v, w in expectedCost:
        adj_exp[u].append((v, w))
        adj_exp[v].append((u, w))

    dist = {}
    pq = [(0, 1)]
    dist[1] = 0

    while pq:
        d, u = heapq.heappop(pq)

        if d > dist.get(u, float('inf')):
            continue

        for v, w in adj[u]:
            expected_w = next((w_exp for v_exp, w_exp in adj_exp[u] if v_exp == v), float('inf'))

            if expected_w != float('inf'):
                new_dist = d + min(w, expected_w)
            else:
                new_dist = d + w

            if new_dist < dist.get(v, float('inf')):
                dist[v] = new_dist
                heapq.heappush(pq, (new_dist, v))

    return dist.get(n, -1)