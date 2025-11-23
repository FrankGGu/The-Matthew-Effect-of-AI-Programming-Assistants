from collections import deque

def find_shortest_cycle(n: int, edges: list[list[int]]) -> int:
    adj = [[] for _ in range(n)]
    for u, v in edges:
        adj[u].append(v)
        adj[v].append(u)

    ans = float('inf')
    for start_node in range(n):
        dist = [-1] * n
        parent = [-1] * n
        q = deque([start_node])
        dist[start_node] = 0

        while q:
            u = q.popleft()
            for v in adj[u]:
                if dist[v] == -1:
                    dist[v] = dist[u] + 1
                    parent[v] = u
                    q.append(v)
                elif parent[u] != v and parent[v] != u:
                    ans = min(ans, dist[u] + dist[v] + 1)

    return ans if ans != float('inf') else -1