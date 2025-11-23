class Solution:
    def criticalConnections(self, n: int, connections: List[List[int]]) -> List[List[int]]:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in connections:
            graph[u].append(v)
            graph[v].append(u)

        ids = [0] * n
        low = [0] * n
        visited = [False] * n
        result = []
        id_counter = 0

        def dfs(at, parent, graph):
            nonlocal id_counter
            visited[at] = True
            id_counter += 1
            ids[at] = low[at] = id_counter

            for to in graph[at]:
                if to == parent:
                    continue
                if not visited[to]:
                    dfs(to, at, graph)
                    low[at] = min(low[at], low[to])
                    if ids[at] < low[to]:
                        result.append([at, to])
                else:
                    low[at] = min(low[at], ids[to])

        for i in range(n):
            if not visited[i]:
                dfs(i, -1, graph)

        return result