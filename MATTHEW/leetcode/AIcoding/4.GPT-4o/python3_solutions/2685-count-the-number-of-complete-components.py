class Solution:
    def countCompleteComponents(self, n: int, edges: List[List[int]]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        def bfs(start):
            queue = deque([start])
            visited.add(start)
            nodes = 0
            while queue:
                node = queue.popleft()
                nodes += 1
                for neighbor in graph[node]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append(neighbor)
            return nodes

        visited = set()
        complete_components = 0

        for i in range(n):
            if i not in visited:
                nodes_count = bfs(i)
                edges_count = sum(len(graph[node]) for node in visited if node >= i) // 2
                if edges_count == (nodes_count * (nodes_count - 1)) // 2:
                    complete_components += 1

        return complete_components