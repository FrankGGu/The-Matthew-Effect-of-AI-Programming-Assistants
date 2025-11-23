from collections import deque, defaultdict
from typing import List

class Solution:
    def buildMatrix(self, k: int, rowConditions: List[List[int]], colConditions: List[List[int]]) -> List[List[int]]:
        def topologicalSort(edges, n):
            graph = defaultdict(list)
            in_degree = [0] * (n + 1)
            for u, v in edges:
                graph[u].append(v)
                in_degree[v] += 1
            queue = deque()
            for i in range(1, n + 1):
                if in_degree[i] == 0:
                    queue.append(i)
            result = []
            while queue:
                node = queue.popleft()
                result.append(node)
                for neighbor in graph[node]:
                    in_degree[neighbor] -= 1
                    if in_degree[neighbor] == 0:
                        queue.append(neighbor)
            return result if len(result) == n else []

        row_order = topologicalSort(rowConditions, k)
        col_order = topologicalSort(colConditions, k)

        if not row_order or not col_order:
            return []

        row_pos = {num: i for i, num in enumerate(row_order)}
        col_pos = {num: i for i, num in enumerate(col_order)}

        matrix = [[0] * k for _ in range(k)]
        for num in range(1, k + 1):
            matrix[row_pos[num]][col_pos[num]] = num

        return matrix