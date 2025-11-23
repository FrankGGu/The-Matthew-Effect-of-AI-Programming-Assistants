class Solution:
    def countMaxDistance(self, n: int, edges: List[List[int]]) -> List[int]:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        result = [0] * (n - 1)

        def bfs(start):
            visited = [-1] * n
            q = deque()
            q.append(start)
            visited[start] = 0
            max_dist = 0
            while q:
                node = q.popleft()
                for neighbor in graph[node]:
                    if visited[neighbor] == -1:
                        visited[neighbor] = visited[node] + 1
                        max_dist = max(max_dist, visited[neighbor])
                        q.append(neighbor)
            return max_dist

        for i in range(n):
            max_dist = 0
            for j in range(n):
                if i != j:
                    dist = bfs(i)
                    max_dist = max(max_dist, dist)
            if max_dist > 0:
                result[max_dist - 1] += 1

        return result