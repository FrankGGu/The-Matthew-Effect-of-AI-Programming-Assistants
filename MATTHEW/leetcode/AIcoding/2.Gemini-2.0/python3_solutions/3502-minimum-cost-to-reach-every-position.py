import heapq

def minCost(startPos: list[int], targetPos: list[int], specialRoads: list[list[int]]) -> int:
    graph = {}
    graph[(startPos[0], startPos[1])] = {}
    for road in specialRoads:
        u = (road[0], road[1])
        v = (road[2], road[3])
        cost = road[4]
        if u not in graph:
            graph[u] = {}
        if v not in graph:
            graph[v] = {}
        graph[u][v] = cost
        graph[(startPos[0], startPos[1])][u] = abs(startPos[0] - road[0]) + abs(startPos[1] - road[1])

    target = (targetPos[0], targetPos[1])
    for road in specialRoads:
        u = (road[0], road[1])
        v = (road[2], road[3])
        graph[u][target] = abs(targetPos[0] - road[2]) + abs(targetPos[1] - road[3])
        graph[v][target] = abs(targetPos[0] - road[2]) + abs(targetPos[1] - road[3])

    graph[target] = {}
    for road in specialRoads:
        u = (road[0], road[1])
        v = (road[2], road[3])
        if u not in graph:
            graph[u] = {}
        if v not in graph:
            graph[v] = {}
        graph[target][u] = abs(targetPos[0] - road[0]) + abs(targetPos[1] - road[1])
        graph[target][v] = abs(targetPos[0] - road[2]) + abs(targetPos[1] - road[3])

    graph[(startPos[0], startPos[1])][target] = abs(startPos[0] - targetPos[0]) + abs(startPos[1] - targetPos[1])

    dist = {}
    for node in graph:
        dist[node] = float('inf')
    dist[(startPos[0], startPos[1])] = 0

    pq = [(0, (startPos[0], startPos[1]))]

    while pq:
        d, u = heapq.heappop(pq)
        if d > dist[u]:
            continue

        for v, weight in graph[u].items():
            if dist[u] + weight < dist[v]:
                dist[v] = dist[u] + weight
                heapq.heappush(pq, (dist[v], v))

        for road in specialRoads:
            x1, y1, x2, y2, cost = road
            uu = (x1,y1)
            vv = (x2,y2)

            if dist[u] + abs(u[0]-vv[0])+abs(u[1]-vv[1]) < dist[vv] :
              dist[vv] = dist[u] + abs(u[0]-vv[0])+abs(u[1]-vv[1])
              heapq.heappush(pq, (dist[vv], vv))

            if dist[u] + abs(u[0]-uu[0])+abs(u[1]-uu[1]) < dist[uu]:
              dist[uu] = dist[u] + abs(u[0]-uu[0])+abs(u[1]-uu[1])
              heapq.heappush(pq, (dist[uu], uu))

    return dist[target]