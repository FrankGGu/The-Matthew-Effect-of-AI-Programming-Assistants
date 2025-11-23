class Solution:
    def maxEmployees(self, n: int, relations: List[List[int]]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        in_degree = [0] * n
        for u, v in relations:
            graph[u].append(v)
            in_degree[v] += 1

        queue = deque()
        for i in range(n):
            if in_degree[i] == 0:
                queue.append(i)

        result = 0
        while queue:
            node = queue.popleft()
            result += 1
            for neighbor in graph[node]:
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        return result