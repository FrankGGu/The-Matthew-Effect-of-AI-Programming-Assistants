from collections import defaultdict

class Solution:
    def countSubTrees(self, n: int, edges: list[list[int]], labels: str) -> list[int]:
        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        result = [0] * n
        visited = [False] * n

        def dfs(node):
            visited[node] = True
            counts = defaultdict(int)
            counts[labels[node]] = 1

            for neighbor in adj[node]:
                if not visited[neighbor]:
                    neighbor_counts = dfs(neighbor)
                    for label, count in neighbor_counts.items():
                        counts[label] += count

            result[node] = counts[labels[node]]
            return counts

        dfs(0)
        return result