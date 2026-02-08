from collections import defaultdict, deque

def find_edges(n, edges):
    graph = defaultdict(list)
    for u, v in edges:
        graph[u].append(v)
        graph[v].append(u)

    dist = [-1] * (n + 1)
    dist[1] = 0
    queue = deque([1])

    while queue:
        node = queue.popleft()
        for neighbor in graph[node]:
            if dist[neighbor] == -1:
                dist[neighbor] = dist[node] + 1
                queue.append(neighbor)

    edges_in_shortest_paths = set()
    for u, v in edges:
        if dist[u] + 1 == dist[v] or dist[v] + 1 == dist[u]:
            edges_in_shortest_paths.add((min(u, v), max(u, v)))

    return len(edges_in_shortest_paths)