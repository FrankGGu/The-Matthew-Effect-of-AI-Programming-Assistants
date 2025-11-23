import collections

class Solution:
    def buildMatrix(self, k: int, rowConditions: list[list[int]], colConditions: list[list[int]]) -> list[list[int]]:

        def topological_sort(n, conditions):
            adj = collections.defaultdict(list)
            in_degree = [0] * (n + 1)

            for u, v in conditions:
                adj[u].append(v)
                in_degree[v] += 1

            q = collections.deque()
            for i in range(1, n + 1):
                if in_degree[i] == 0:
                    q.append(i)

            result_order = []
            while q:
                u = q.popleft()
                result_order.append(u)
                for v in adj[u]:
                    in_degree[v] -= 1
                    if in_degree[v] == 0:
                        q.append(v)

            if len(result_order) == n:
                return result_order
            else:
                return []

        row_order = topological_sort(k, rowConditions)
        if not row_order:
            return []

        col_order = topological_sort(k, colConditions)
        if not col_order:
            return []

        pos_row = [0] * (k + 1)
        for i in range(k):
            pos_row[row_order[i]] = i

        pos_col = [0] * (k + 1)
        for i in range(k):
            pos_col[col_order[i]] = i

        matrix = [[0] * k for _ in range(k)]
        for num in range(1, k + 1):
            matrix[pos_row[num]][pos_col[num]] = num

        return matrix