import heapq

def secondMinimum(n: int, edges: List[List[int]], time: int, change: int) -> int:
    graph = [[] for _ in range(n)]
    for u, v in edges:
        graph[u - 1].append(v - 1)
        graph[v - 1].append(u - 1)

    pq = [(0, 0)]  # (current_time, node)
    visited = [[False] * 2 for _ in range(n)]

    while pq:
        current_time, node = heapq.heappop(pq)

        if node == n - 1 and visited[node][1]:
            return current_time

        for neighbor in graph[node]:
            wait_time = (current_time // change + 1) * change - current_time
            new_time = current_time + wait_time + time

            if not visited[neighbor][0]:
                visited[neighbor][0] = True
                heapq.heappush(pq, (new_time, neighbor))

            if visited[neighbor][0] and not visited[neighbor][1]:
                visited[neighbor][1] = True
                heapq.heappush(pq, (new_time, neighbor))

    return -1