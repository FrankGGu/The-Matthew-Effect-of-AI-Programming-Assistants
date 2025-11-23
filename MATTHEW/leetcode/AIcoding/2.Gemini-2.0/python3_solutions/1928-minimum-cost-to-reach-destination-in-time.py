import heapq

def minCost(maxTime: int, costs: list[int], times: list[int]) -> int:
    n = len(costs)
    graph = [[] for _ in range(n)]
    for i in range(len(times)):
        u, v = i // n, i % n
        if u != v:
            graph[u].append((v, times[i]))
            graph[v].append((u, times[i]))

    min_cost = float('inf')
    pq = [(costs[0], 0, 0)]  # (cost, node, time)
    min_time = [float('inf')] * n
    min_time[0] = 0

    while pq:
        cost, node, time = heapq.heappop(pq)

        if node == n - 1:
            min_cost = min(min_cost, cost)
            continue

        if time > min_time[node] or time > maxTime:
            continue

        for neighbor, travel_time in graph[node]:
            new_time = time + travel_time
            if new_time <= maxTime:
                new_cost = cost + costs[neighbor]
                if new_time < min_time[neighbor]:
                    min_time[neighbor] = new_time
                    heapq.heappush(pq, (new_cost, neighbor, new_time))

    return min_cost if min_cost != float('inf') else -1