class Solution:
    def minimumLevels(self, n: int, edges: List[List[int]]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        levels = [-1] * n
        levels[0] = 0
        queue = deque([0])

        while queue:
            node = queue.popleft()
            for neighbor in graph[node]:
                if levels[neighbor] == -1:
                    levels[neighbor] = levels[node] + 1
                    queue.append(neighbor)

        return max(levels) + 1 if all(l != -1 for l in levels) else -1