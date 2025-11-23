from collections import deque

class Solution:
    def buildMatrix(self, k: int, rowConditions: List[List[int]], colConditions: List[List[int]]) -> List[List[int]]:
        def topological_sort(conditions, k):
            graph = [[] for _ in range(k + 1)]
            in_degree = [0] * (k + 1)
            for a, b in conditions:
                graph[a].append(b)
                in_degree[b] += 1
            queue = deque()
            for i in range(1, k + 1):
                if in_degree[i] == 0:
                    queue.append(i)
            order = []
            while queue:
                node = queue.popleft()
                order.append(node)
                for neighbor in graph[node]:
                    in_degree[neighbor] -= 1
                    if in_degree[neighbor] == 0:
                        queue.append(neighbor)
            return order if len(order) == k else None

        row_order = topological_sort(rowConditions, k)
        col_order = topological_sort(colConditions, k)

        if not row_order or not col_order:
            return []

        row_pos = {num: i for i, num in enumerate(row_order)}
        col_pos = {num: i for i, num in enumerate(col_order)}

        matrix = [[0] * k for _ in range(k)]
        for num in range(1, k + 1):
            matrix[row_pos[num]][col_pos[num]] = num

        return matrix