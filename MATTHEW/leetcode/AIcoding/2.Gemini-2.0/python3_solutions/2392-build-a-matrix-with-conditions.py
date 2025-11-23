from collections import defaultdict

class Solution:
    def buildMatrix(self, k: int, rowConditions: list[list[int]], colConditions: list[list[int]]) -> list[list[int]]:
        def topological_sort(conditions):
            graph = defaultdict(list)
            in_degree = [0] * (k + 1)
            for u, v in conditions:
                graph[u].append(v)
                in_degree[v] += 1

            queue = [i for i in range(1, k + 1) if in_degree[i] == 0]
            result = []
            while queue:
                u = queue.pop(0)
                result.append(u)
                for v in graph[u]:
                    in_degree[v] -= 1
                    if in_degree[v] == 0:
                        queue.append(v)
            return result if len(result) == k else []

        row_order = topological_sort(rowConditions)
        col_order = topological_sort(colConditions)

        if not row_order or not col_order:
            return []

        row_pos = {val: i for i, val in enumerate(row_order)}
        col_pos = {val: i for i, val in enumerate(col_order)}

        matrix = [[0] * k for _ in range(k)]
        for i in range(1, k + 1):
            matrix[row_pos[i]][col_pos[i]] = i

        return matrix