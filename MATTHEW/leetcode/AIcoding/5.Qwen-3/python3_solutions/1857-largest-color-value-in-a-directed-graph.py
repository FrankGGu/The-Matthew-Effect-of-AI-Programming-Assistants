from collections import defaultdict, deque

class Solution:
    def largestColorValue(self, n: int, edges: List[List[int]], colors: List[int]) -> int:
        graph = defaultdict(list)
        in_degree = [0] * n
        for u, v in edges:
            graph[u].append(v)
            in_degree[v] += 1

        queue = deque()
        for i in range(n):
            if in_degree[i] == 0:
                queue.append(i)

        color_count = [[0] * 26 for _ in range(n)]
        max_color = 0

        while queue:
            node = queue.popleft()
            for neighbor in graph[node]:
                for i in range(26):
                    color_count[neighbor][i] = max(color_count[neighbor][i], color_count[node][i])
                color_count[neighbor][colors[node]] += 1
                max_color = max(max_color, color_count[neighbor][colors[node]])
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        return max_color