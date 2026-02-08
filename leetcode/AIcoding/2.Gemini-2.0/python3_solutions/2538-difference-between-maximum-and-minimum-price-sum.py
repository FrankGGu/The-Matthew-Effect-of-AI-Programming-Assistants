def max_profit(n: int, edges: list[list[int]], price: list[int]) -> int:
    graph = [[] for _ in range(n)]
    for u, v in edges:
        graph[u].append(v)
        graph[v].append(u)

    max_sum = 0

    def dfs(node, parent):
        nonlocal max_sum
        max_path_sum1 = 0
        max_path_sum2 = 0

        for neighbor in graph[node]:
            if neighbor != parent:
                path_sum = dfs(neighbor, node)
                if path_sum > max_path_sum1:
                    max_path_sum2 = max_path_sum1
                    max_path_sum1 = path_sum
                elif path_sum > max_path_sum2:
                    max_path_sum2 = path_sum

        max_sum = max(max_sum, max_path_sum1 + max_path_sum2 + price[node])
        return max_path_sum1 + price[node]

    dfs(0, -1)
    total_sum = sum(price)
    return max_sum - min(price)