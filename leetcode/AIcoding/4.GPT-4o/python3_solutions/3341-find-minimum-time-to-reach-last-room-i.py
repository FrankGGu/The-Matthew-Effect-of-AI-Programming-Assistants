from collections import deque

def minimumTime(n: int, corridors: List[List[int]]) -> int:
    graph = [[] for _ in range(n)]
    for u, v, t in corridors:
        graph[u-1].append((v-1, t))
        graph[v-1].append((u-1, t))

    dist = [float('inf')] * n
    dist[0] = 0
    dq = deque([(0, 0)])  # (current node, current time)

    while dq:
        node, time = dq.popleft()
        for neighbor, travel_time in graph[node]:
            new_time = time + travel_time
            if travel_time % 2 == 1:  # If travel time is odd, wait 1 hour
                new_time += 1
            if new_time < dist[neighbor]:
                dist[neighbor] = new_time
                if travel_time % 2 == 0:
                    dq.appendleft((neighbor, new_time))
                else:
                    dq.append((neighbor, new_time))

    return dist[n-1] if dist[n-1] != float('inf') else -1