class Solution:
    def longestCycle(self, n: int, edges: list[int]) -> int:
        adj = [[] for _ in range(n)]
        for i, edge in enumerate(edges):
            if edge != -1:
                adj[i].append(edge)

        visited = [0] * n
        ans = -1

        def dfs(node, path, path_map):
            nonlocal ans
            visited[node] = 1
            path.append(node)
            path_map[node] = len(path) - 1

            for neighbor in adj[node]:
                if visited[neighbor] == 0:
                    dfs(neighbor, path, path_map)
                elif neighbor in path_map:
                    ans = max(ans, len(path) - path_map[neighbor])

            path.pop()
            del path_map[node]

        for i in range(n):
            if visited[i] == 0:
                dfs(i, [], {})

        return ans