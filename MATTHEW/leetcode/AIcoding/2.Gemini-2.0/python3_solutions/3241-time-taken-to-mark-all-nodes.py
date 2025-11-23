from collections import defaultdict

def timeTaken(n: int, edges: list[list[int]], signalSpeed: list[int]) -> list[int]:
    graph = defaultdict(list)
    for u, v in edges:
        graph[u].append(v)
        graph[v].append(u)

    result = [0] * (n + 1)
    visited = [False] * (n + 1)
    visited[1] = True
    queue = [(1, 0)]

    while queue:
        next_queue = []
        for node, time in queue:
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    visited[neighbor] = True
                    new_time = time + signalSpeed[node - 1]
                    result[neighbor] = new_time
                    next_queue.append((neighbor, new_time))
        queue = next_queue

    return result[1:]