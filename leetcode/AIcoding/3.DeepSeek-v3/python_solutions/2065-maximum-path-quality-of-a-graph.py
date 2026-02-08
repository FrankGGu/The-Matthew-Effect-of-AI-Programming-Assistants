class Solution:
    def maximalPathQuality(self, values: List[int], edges: List[List[int]], maxTime: int) -> int:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v, time in edges:
            graph[u].append((v, time))
            graph[v].append((u, time))

        self.max_quality = 0
        visited = defaultdict(int)
        visited[0] = 1

        def dfs(node, current_time, current_quality):
            if node == 0:
                self.max_quality = max(self.max_quality, current_quality)

            for neighbor, time in graph[node]:
                if current_time + time <= maxTime:
                    if visited[neighbor] == 0:
                        current_quality += values[neighbor]
                    visited[neighbor] += 1
                    dfs(neighbor, current_time + time, current_quality)
                    visited[neighbor] -= 1
                    if visited[neighbor] == 0:
                        current_quality -= values[neighbor]

        dfs(0, 0, values[0])
        return self.max_quality