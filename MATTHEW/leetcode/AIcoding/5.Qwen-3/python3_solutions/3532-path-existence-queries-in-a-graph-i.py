class Solution:
    def isAccessible(self, n: int, edges: List[List[int]], queries: List[List[int]]) -> List[bool]:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        def bfs(start, end):
            visited = set()
            queue = deque([start])
            visited.add(start)
            while queue:
                node = queue.popleft()
                if node == end:
                    return True
                for neighbor in graph[node]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append(neighbor)
            return False

        result = []
        for u, v in queries:
            result.append(bfs(u, v))
        return result