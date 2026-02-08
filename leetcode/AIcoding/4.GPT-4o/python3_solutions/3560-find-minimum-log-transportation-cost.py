def minCost(transport_costs):
    import heapq
    from collections import defaultdict

    graph = defaultdict(list)
    for u, v, cost in transport_costs:
        graph[u].append((v, cost))
        graph[v].append((u, cost))

    min_heap = [(0, 0)]  # (cost, node)
    min_cost = {0: 0}
    visited = set()

    while min_heap:
        cost, u = heapq.heappop(min_heap)
        if u in visited:
            continue
        visited.add(u)

        for v, edge_cost in graph[u]:
            if v not in visited:
                new_cost = cost + edge_cost
                if v not in min_cost or new_cost < min_cost[v]:
                    min_cost[v] = new_cost
                    heapq.heappush(min_heap, (new_cost, v))

    return min_cost[max(min_cost.keys())] if max(min_cost.keys()) in min_cost else -1