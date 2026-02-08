class Solution:
    def protectSpaceCity(self, n: int, roads: List[List[int]]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in roads:
            graph[u].append(v)
            graph[v].append(u)

        def bfs(start):
            visited = set()
            queue = deque([start])
            visited.add(start)
            while queue:
                node = queue.popleft()
                for neighbor in graph[node]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append(neighbor)
            return visited

        components = 0
        visited_global = set()
        for i in range(n):
            if i not in visited_global:
                bfs(i)
                components += 1
                visited_global.update(bfs(i))

        return components - 1