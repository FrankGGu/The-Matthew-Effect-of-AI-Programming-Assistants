class Solution:
    def maximalPathQuality(self, values: list[int], edges: list[list[int]], maxTime: int) -> int:
        n = len(values)
        adj = [[] for _ in range(n)]
        for u, v, w in edges:
            adj[u].append((v, w))
            adj[v].append((u, w))

        max_quality = 0
        visited = [0] * n

        def dfs(node, current_time, current_quality):
            nonlocal max_quality
            visited[node] += 1
            if node == 0:
                max_quality = max(max_quality, current_quality)

            for neighbor, weight in adj[node]:
                if current_time + weight <= maxTime:
                    if visited[neighbor] == 0:
                        dfs(neighbor, current_time + weight, current_quality + values[neighbor])
                    else:
                        dfs(neighbor, current_time + weight, current_quality)

            visited[node] -= 1

        dfs(0, 0, values[0])
        return max_quality