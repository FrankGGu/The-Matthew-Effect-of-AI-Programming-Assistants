from collections import defaultdict

class Solution:
    def countSubtrees(self, n: int, edges: list[list[int]], queries: list[list[int]]) -> list[int]:
        adj = defaultdict(list)
        for u, v in edges:
            adj[u - 1].append(v - 1)
            adj[v - 1].append(u - 1)

        sizes = [0] * n

        def dfs(node, parent, blocked):
            sizes[node] = 1
            for neighbor in adj[node]:
                if neighbor != parent and neighbor != blocked:
                    sizes[node] += dfs(neighbor, node, blocked)
            return sizes[node]

        ans = []
        for u, v in queries:
            sizes = [0] * n
            dfs(u - 1, -1, v - 1)
            ans.append(sizes[u - 1])

        return ans