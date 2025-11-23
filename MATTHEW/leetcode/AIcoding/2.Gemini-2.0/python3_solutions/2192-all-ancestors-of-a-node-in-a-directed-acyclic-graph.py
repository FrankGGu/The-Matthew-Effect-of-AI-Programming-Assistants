from collections import defaultdict, deque

class Solution:
    def getAncestors(self, n: int, edges: list[list[int]]) -> list[list[int]]:
        graph = defaultdict(list)
        in_degree = [0] * n
        for u, v in edges:
            graph[u].append(v)
            in_degree[v] += 1

        ancestors = [set() for _ in range(n)]

        queue = deque([i for i in range(n) if in_degree[i] == 0])

        while queue:
            node = queue.popleft()

            for neighbor in graph[node]:
                ancestors[neighbor].add(node)
                ancestors[neighbor].update(ancestors[node])

                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        result = [sorted(list(ancestors[i])) for i in range(n)]
        return result