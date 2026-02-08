class Solution:
    def frogPosition(self, n: int, edges: List[List[int]], t: int, target: int) -> float:
        graph = [[] for _ in range(n + 1)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = [False] * (n + 1)
        visited[1] = True
        queue = [(1, 1.0, 0)]

        while queue:
            node, prob, time = queue.pop(0)

            if time > t:
                continue

            if node == target:
                if time == t or len([neighbor for neighbor in graph[node] if not visited[neighbor]]) == 0:
                    return prob
                else:
                    return 0.0

            next_nodes = [neighbor for neighbor in graph[node] if not visited[neighbor]]
            num_next = len(next_nodes)
            if num_next == 0:
                if time == t and node == target:
                    return prob
                else:
                    continue

            next_prob = prob / num_next

            for next_node in next_nodes:
                visited[next_node] = True
                queue.append((next_node, next_prob, time + 1))

        return 0.0