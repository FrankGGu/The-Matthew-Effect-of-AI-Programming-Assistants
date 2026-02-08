from collections import deque

class Solution:
    def magnificentSets(self, n: int, edges: List[List[int]]) -> int:
        graph = [[] for _ in range(n + 1)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = [0] * (n + 1)
        components = []

        for node in range(1, n + 1):
            if not visited[node]:
                queue = deque([node])
                visited[node] = 1
                component = []
                while queue:
                    current = queue.popleft()
                    component.append(current)
                    for neighbor in graph[current]:
                        if not visited[neighbor]:
                            visited[neighbor] = 1
                            queue.append(neighbor)
                components.append(component)

        def bfs(start):
            distance = [0] * (n + 1)
            queue = deque([start])
            distance[start] = 1
            max_distance = 1
            while queue:
                current = queue.popleft()
                for neighbor in graph[current]:
                    if distance[neighbor] == 0:
                        distance[neighbor] = distance[current] + 1
                        max_distance = distance[neighbor]
                        queue.append(neighbor)
                    elif abs(distance[neighbor] - distance[current]) != 1:
                        return -1
            return max_distance

        max_groups = 0
        for component in components:
            current_max = -1
            for node in component:
                res = bfs(node)
                if res == -1:
                    return -1
                current_max = max(current_max, res)
            max_groups += current_max

        return max_groups