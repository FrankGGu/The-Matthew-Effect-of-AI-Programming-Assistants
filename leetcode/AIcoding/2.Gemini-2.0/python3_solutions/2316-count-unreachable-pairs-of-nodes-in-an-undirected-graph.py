class Solution:
    def countPairs(self, n: int, edges: list[list[int]]) -> int:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        visited = [False] * n
        components = []

        def dfs(node):
            visited[node] = True
            count = 1
            for neighbor in adj[node]:
                if not visited[neighbor]:
                    count += dfs(neighbor)
            return count

        for i in range(n):
            if not visited[i]:
                components.append(dfs(i))

        ans = 0
        remaining_nodes = n
        for component_size in components:
            ans += component_size * (remaining_nodes - component_size)
            remaining_nodes -= component_size

        return ans