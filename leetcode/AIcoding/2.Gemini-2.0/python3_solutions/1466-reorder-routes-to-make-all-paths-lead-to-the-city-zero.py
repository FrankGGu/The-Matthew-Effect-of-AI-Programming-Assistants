from collections import defaultdict, deque

def minReorder(n: int, connections: list[list[int]]) -> int:
    graph = defaultdict(list)
    for u, v in connections:
        graph[u].append((v, 1))
        graph[v].append((u, 0))

    visited = [False] * n
    queue = deque([0])
    visited[0] = True
    reorders = 0

    while queue:
        u = queue.popleft()
        for v, cost in graph[u]:
            if not visited[v]:
                reorders += cost
                visited[v] = True
                queue.append(v)

    return reorders