class Solution:
    def maximizeTheTargetNodes(self, edges: List[List[int]]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = set()
        max_target_nodes = 0

        def bfs(start):
            queue = deque([start])
            visited.add(start)
            count = 0

            while queue:
                node = queue.popleft()
                count += 1
                for neighbor in graph[node]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append(neighbor)
            return count

        for node in graph:
            if node not in visited:
                max_target_nodes = max(max_target_nodes, bfs(node))

        return max_target_nodes