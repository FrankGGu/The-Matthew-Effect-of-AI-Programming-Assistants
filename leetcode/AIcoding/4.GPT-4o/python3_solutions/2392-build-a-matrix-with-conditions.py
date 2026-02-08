def buildMatrix(k: int, rowConditions: List[List[int]], colConditions: List[List[int]]) -> List[List[int]]:
    from collections import deque, defaultdict

    def topological_sort(conditions):
        graph = defaultdict(list)
        indegree = [0] * (k + 1)
        for u, v in conditions:
            graph[u].append(v)
            indegree[v] += 1

        queue = deque()
        for i in range(1, k + 1):
            if indegree[i] == 0:
                queue.append(i)

        sorted_order = []
        while queue:
            node = queue.popleft()
            sorted_order.append(node)
            for neighbor in graph[node]:
                indegree[neighbor] -= 1
                if indegree[neighbor] == 0:
                    queue.append(neighbor)

        return sorted_order if len(sorted_order) == k else []

    row_order = topological_sort(rowConditions)
    col_order = topological_sort(colConditions)

    if not row_order or not col_order:
        return []

    position_row = {value: index for index, value in enumerate(row_order)}
    position_col = {value: index for index, value in enumerate(col_order)}

    matrix = [[0] * k for _ in range(k)]
    for i in range(k):
        for j in range(k):
            matrix[i][j] = (position_row[i + 1] * k + position_col[j + 1]) + 1

    return matrix