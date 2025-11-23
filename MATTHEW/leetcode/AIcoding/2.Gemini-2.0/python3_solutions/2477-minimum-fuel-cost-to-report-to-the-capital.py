from collections import defaultdict

def minimumFuelCost(n: int, roads: list[list[int]], seats: int) -> int:
    if n == 1:
        return 0

    adj = defaultdict(list)
    for u, v in roads:
        adj[u].append(v)
        adj[v].append(u)

    fuel = 0
    visited = [False] * n
    visited[0] = True

    def dfs(node):
        nonlocal fuel
        passengers = 1
        for neighbor in adj[node]:
            if not visited[neighbor]:
                visited[neighbor] = True
                p = dfs(neighbor)
                passengers += p
                fuel += (p + seats - 1) // seats
        return passengers

    dfs(0)
    return fuel