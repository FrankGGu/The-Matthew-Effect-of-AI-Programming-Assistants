from typing import List

class Solution:
    def maximumDetonation(self, bombs: List[List[int]]) -> int:
        n = len(bombs)
        graph = [[] for _ in range(n)]

        for i in range(n):
            x1, y1, r1 = bombs[i]
            for j in range(n):
                if i == j:
                    continue
                x2, y2, _ = bombs[j]
                distance_sq = (x1 - x2) ** 2 + (y1 - y2) ** 2
                if distance_sq <= r1 * r1:
                    graph[i].append(j)

        def dfs(node, visited):
            visited.add(node)
            for neighbor in graph[node]:
                if neighbor not in visited:
                    dfs(neighbor, visited)
            return len(visited)

        max_count = 0
        for i in range(n):
            visited = set()
            max_count = max(max_count, dfs(i, visited))

        return max_count