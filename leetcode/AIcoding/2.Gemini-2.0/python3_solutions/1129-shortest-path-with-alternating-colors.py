from collections import deque

def shortestAlternatingPaths(n: int, redEdges: list[list[int]], blueEdges: list[list[int]]) -> list[int]:
    graph = [[] for _ in range(n)]
    for u, v in redEdges:
        graph[u].append((v, 0))  # 0 for red
    for u, v in blueEdges:
        graph[u].append((v, 1))  # 1 for blue

    ans = [-1] * n
    ans[0] = 0
    q = deque([(0, 0, -1)])  # node, distance, last_color
    visited = set([(0, -1)])  # (node, last_color)

    while q:
        node, dist, last_color = q.popleft()
        for neighbor, color in graph[node]:
            if color != last_color and (neighbor, color) not in visited:
                visited.add((neighbor, color))
                if ans[neighbor] == -1:
                    ans[neighbor] = dist + 1
                q.append((neighbor, dist + 1, color))

    return ans