class Solution:
    def checkIfPrerequisite(self, n: int, prerequisites: List[List[int]], queries: List[List[int]]) -> List[bool]:
        graph = [[] for _ in range(n)]
        for u, v in prerequisites:
            graph[u].append(v)

        reach = [[False] * n for _ in range(n)]
        for i in range(n):
            reach[i][i] = True

        def dfs(node):
            for neighbor in graph[node]:
                if not reach[i][neighbor]:
                    reach[i][neighbor] = True
                    dfs(neighbor)

        for i in range(n):
            dfs(i)

        return [reach[u][v] for u, v in queries]