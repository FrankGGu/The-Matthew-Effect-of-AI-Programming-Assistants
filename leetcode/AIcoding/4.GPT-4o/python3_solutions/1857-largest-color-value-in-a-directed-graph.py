from collections import defaultdict, deque

class Solution:
    def largestColorValue(self, colors: str, edges: List[List[int]]) -> int:
        n = len(colors)
        graph = defaultdict(list)
        indegree = [0] * n
        color_count = [defaultdict(int) for _ in range(n)]

        for u, v in edges:
            graph[u].append(v)
            indegree[v] += 1

        queue = deque()
        for i in range(n):
            if indegree[i] == 0:
                queue.append(i)
                color_count[i][colors[i]] += 1

        max_color_value = 0
        visited = 0

        while queue:
            node = queue.popleft()
            visited += 1
            max_color_value = max(max_color_value, max(color_count[node].values()))

            for neighbor in graph[node]:
                for color, count in color_count[node].items():
                    color_count[neighbor][color] = max(color_count[neighbor][color], count)
                color_count[neighbor][colors[neighbor]] += 1
                indegree[neighbor] -= 1
                if indegree[neighbor] == 0:
                    queue.append(neighbor)

        return max_color_value if visited == n else -1