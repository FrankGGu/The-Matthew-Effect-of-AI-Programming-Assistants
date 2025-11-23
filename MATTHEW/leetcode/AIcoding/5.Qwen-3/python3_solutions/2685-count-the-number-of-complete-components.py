from collections import defaultdict, deque

class Solution:
    def countComponents(self, n: int, edges: List[List[int]]) -> int:
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = [False] * n
        count = 0

        for i in range(n):
            if not visited[i]:
                queue = deque([i])
                visited[i] = True
                size = 0
                while queue:
                    node = queue.popleft()
                    size += 1
                    for neighbor in graph[node]:
                        if not visited[neighbor]:
                            visited[neighbor] = True
                            queue.append(neighbor)
                if size == len(graph[i]):
                    count += 1

        return count