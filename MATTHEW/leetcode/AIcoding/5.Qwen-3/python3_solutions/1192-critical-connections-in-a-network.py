class Solution:
    def criticalConnections(self, n: int, connections: List[List[int]]) -> List[List[int]]:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in connections:
            graph[u].append(v)
            graph[v].append(u)

        result = []
        visited = [False] * n
        disc = [float('inf')] * n
        low = [float('inf')] * n
        time = [0]

        def dfs(u, parent):
            visited[u] = True
            disc[u] = low[u] = time[0]
            time[0] += 1

            for v in graph[u]:
                if v == parent:
                    continue
                if not visited[v]:
                    dfs(v, u)
                    low[u] = min(low[u], low[v])
                    if low[v] > disc[u]:
                        result.append([u, v])
                else:
                    low[u] = min(low[u], disc[v])

        for i in range(n):
            if not visited[i]:
                dfs(i, -1)

        return result