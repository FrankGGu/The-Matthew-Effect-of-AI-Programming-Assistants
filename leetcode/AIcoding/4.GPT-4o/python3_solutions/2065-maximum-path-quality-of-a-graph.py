class Solution:
    def maximumPathQuality(self, values: List[int], edges: List[List[int]], maxTime: int) -> int:
        from collections import defaultdict
        import heapq

        graph = defaultdict(list)
        for u, v, time in edges:
            graph[u].append((v, time))
            graph[v].append((u, time))

        n = len(values)
        max_quality = 0

        def dfs(node, time_left, current_quality, visited):
            nonlocal max_quality
            if time_left < 0:
                return
            if node == 0:
                max_quality = max(max_quality, current_quality)
            for neighbor, travel_time in graph[node]:
                if neighbor not in visited:
                    visited.add(neighbor)
                    dfs(neighbor, time_left - travel_time, current_quality + values[neighbor], visited)
                    visited.remove(neighbor)
                else:
                    dfs(neighbor, time_left - travel_time, current_quality, visited)

        dfs(0, maxTime, values[0], {0})
        return max_quality