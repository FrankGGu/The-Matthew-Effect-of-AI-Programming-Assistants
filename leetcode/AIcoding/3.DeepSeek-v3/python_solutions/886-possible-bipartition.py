class Solution:
    def possibleBipartition(self, N: int, dislikes: List[List[int]]) -> bool:
        graph = [[] for _ in range(N + 1)]
        for u, v in dislikes:
            graph[u].append(v)
            graph[v].append(u)

        color = {}
        def dfs(node, c=0):
            if node in color:
                return color[node] == c
            color[node] = c
            return all(dfs(neighbor, c ^ 1) for neighbor in graph[node])

        for node in range(1, N + 1):
            if node not in color:
                if not dfs(node):
                    return False
        return True