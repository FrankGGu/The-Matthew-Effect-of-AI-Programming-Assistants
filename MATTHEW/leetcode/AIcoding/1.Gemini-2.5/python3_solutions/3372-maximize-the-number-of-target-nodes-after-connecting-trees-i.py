from collections import defaultdict

class Solution:
    def maximizeTargetNodes(self, n: int, edges: list[list[int]], target: list[int]) -> int:
        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        visited = [False] * n
        component_target_counts = []

        def dfs(node):
            visited[node] = True
            count = target[node]
            for neighbor in adj[node]:
                if not visited[neighbor]:
                    count += dfs(neighbor)
            return count

        for i in range(n):
            if not visited[i]:
                component_target_counts.append(dfs(i))

        if not component_target_counts:
            return 0

        if len(component_target_counts) == 1:
            return component_target_counts[0]

        component_target_counts.sort(reverse=True)

        return component_target_counts[0] + component_target_counts[1]