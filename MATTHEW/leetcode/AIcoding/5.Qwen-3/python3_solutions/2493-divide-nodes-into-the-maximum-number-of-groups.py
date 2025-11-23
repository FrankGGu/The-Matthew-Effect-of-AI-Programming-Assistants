from collections import deque, defaultdict

class Solution:
    def maxGroups(self, n: int, edges: list[list[int]]) -> int:
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        def bfs(start):
            visited = [False] * (n + 1)
            queue = deque()
            queue.append((start, 0))
            visited[start] = True
            max_depth = 0
            while queue:
                node, depth = queue.popleft()
                max_depth = max(max_depth, depth)
                for neighbor in graph[node]:
                    if not visited[neighbor]:
                        visited[neighbor] = True
                        queue.append((neighbor, depth + 1))
            return max_depth

        max_group = 0
        visited = [False] * (n + 1)
        for i in range(1, n + 1):
            if not visited[i]:
                depth = bfs(i)
                max_group += depth + 1

        return max_group