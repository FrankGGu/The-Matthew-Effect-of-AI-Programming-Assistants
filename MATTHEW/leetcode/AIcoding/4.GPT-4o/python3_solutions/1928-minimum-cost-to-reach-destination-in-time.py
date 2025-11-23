import heapq

def minCost(positions, start, end, maxTime):
    n = len(positions)
    graph = {i: [] for i in range(n)}

    for i in range(n):
        for j in range(n):
            if i != j:
                time = abs(positions[i] - positions[j])
                graph[i].append((j, time))

    pq = [(0, start, 0)]  # (cost, position, time)
    costs = {i: float('inf') for i in range(n)}
    costs[start] = 0

    while pq:
        cost, pos, time = heapq.heappop(pq)
        if pos == end and time <= maxTime:
            return cost
        if time > maxTime or cost > costs[pos]:
            continue

        for neighbor, travel_time in graph[pos]:
            new_time = time + travel_time
            new_cost = cost + 1
            if new_time <= maxTime and new_cost < costs[neighbor]:
                costs[neighbor] = new_cost
                heapq.heappush(pq, (new_cost, neighbor, new_time))

    return -1