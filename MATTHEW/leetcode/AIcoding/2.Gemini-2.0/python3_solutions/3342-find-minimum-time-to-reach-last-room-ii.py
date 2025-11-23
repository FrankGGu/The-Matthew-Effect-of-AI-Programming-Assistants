import heapq

def findMinimumTime(entrances, passTime):
    n = len(entrances)
    adj = [[] for _ in range(n)]
    for i in range(n):
        for j in range(n):
            if i != j:
                adj[i].append((j, passTime[i] if i < j else passTime[j]))

    dist = [float('inf')] * n
    dist[0] = 0
    pq = [(0, 0)]

    while pq:
        d, u = heapq.heappop(pq)

        if d > dist[u]:
            continue

        for v, weight in adj[u]:
            wait_time = 0
            if u != 0:
                wait_time = (dist[u] // entrances[u]) * entrances[u]
                if dist[u] % entrances[u] != 0:
                    wait_time += entrances[u]

            if dist[v] > wait_time + dist[u] + weight:
                dist[v] = wait_time + dist[u] + weight
                heapq.heappush(pq, (dist[v], v))

    return dist[n - 1]