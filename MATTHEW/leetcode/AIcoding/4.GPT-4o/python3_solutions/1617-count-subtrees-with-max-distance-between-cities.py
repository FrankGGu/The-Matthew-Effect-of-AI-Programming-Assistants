class Solution:
    def countSubtrees(self, n: int, edges: List[List[int]]) -> List[int]:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        def bfs(start):
            queue = deque([start])
            visited = {start}
            distances = {start: 0}
            max_dist = 0
            while queue:
                node = queue.popleft()
                for neighbor in graph[node]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        distances[neighbor] = distances[node] + 1
                        max_dist = max(max_dist, distances[neighbor])
                        queue.append(neighbor)
            return max_dist

        result = []
        for i in range(n):
            result.append(bfs(i))
        return result