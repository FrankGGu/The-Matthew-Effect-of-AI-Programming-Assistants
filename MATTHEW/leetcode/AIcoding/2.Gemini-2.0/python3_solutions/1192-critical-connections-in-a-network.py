class Solution:
    def criticalConnections(self, n: int, connections: List[List[int]]) -> List[List[int]]:
        graph = [[] for _ in range(n)]
        for u, v in connections:
            graph[u].append(v)
            graph[v].append(u)

        disc = [-1] * n
        low = [-1] * n
        timer = 0
        result = []

        def dfs(node, parent):
            nonlocal timer
            disc[node] = low[node] = timer
            timer += 1

            for neighbor in graph[node]:
                if neighbor == parent:
                    continue

                if disc[neighbor] == -1:
                    dfs(neighbor, node)
                    low[node] = min(low[node], low[neighbor])
                    if low[neighbor] > disc[node]:
                        result.append([node, neighbor])
                else:
                    low[node] = min(low[node], disc[neighbor])

        for i in range(n):
            if disc[i] == -1:
                dfs(i, -1)

        return result