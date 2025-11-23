import heapq

def secondMinimum(n: int, edges: list[list[int]], time: int, change: int) -> int:
    graph = [[] for _ in range(n + 1)]
    for u, v in edges:
        graph[u].append(v)
        graph[v].append(u)

    dist = [[float('inf')] * 2 for _ in range(n + 1)]
    dist[1][0] = 0

    pq = [(0, 1)]  # (time, node)

    while pq:
        d, u = heapq.heappop(pq)

        for v in graph[u]:
            if d + time < dist[v][0]:
                dist[v][0] = d + time
                heapq.heappush(pq, (d + time, v))
            elif d + time > dist[v][0] and d + time < dist[v][1]:
                dist[v][1] = d + time
                heapq.heappush(pq, (d + time, v))

    ans = dist[n][1]
    curr_time = 0
    while curr_time < ans:
        cycle_time = curr_time // change
        if cycle_time % 2 == 1:
            curr_time = (cycle_time + 1) * change
        else:
            break
    return ans