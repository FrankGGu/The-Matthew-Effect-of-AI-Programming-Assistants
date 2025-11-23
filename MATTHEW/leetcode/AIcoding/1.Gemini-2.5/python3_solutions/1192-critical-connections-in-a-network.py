from collections import defaultdict

class Solution:
    def criticalConnections(self, n: int, connections: list[list[int]]) -> list[list[int]]:
        graph = defaultdict(list)
        for u, v in connections:
            graph[u].append(v)
            graph[v].append(u)

        disc = [-1] * n
        low = [-1] * n
        self_time = 0
        result = []

        def dfs(u, parent):
            nonlocal self_time
            disc[u] = low[u] = self_time
            self_time += 1

            for v in graph[u]:
                if v == parent:
                    continue

                if disc[v] == -1:  # Not visited
                    dfs(v, u)
                    low[u] = min(low[u], low[v])
                    if low[v] > disc[u]:
                        result.append([u, v])
                else:  # Visited, back-edge
                    low[u] = min(low[u], disc[v])

        for i in range(n):
            if disc[i] == -1:
                dfs(i, -1)

        return result