from collections import defaultdict, deque

class Solution:
    def validArrangement(self, pairs: list[list[int]]) -> list[list[int]]:
        graph = defaultdict(deque)
        in_degree = defaultdict(int)
        out_degree = defaultdict(int)
        nodes = set()

        for u, v in pairs:
            graph[u].append(v)
            out_degree[u] += 1
            in_degree[v] += 1
            nodes.add(u)
            nodes.add(v)

        start_node = pairs[0][0]
        for node in nodes:
            if out_degree[node] - in_degree[node] == 1:
                start_node = node
                break

        path = []

        def dfs(u):
            while graph[u]:
                v = graph[u].popleft()
                dfs(v)
                path.append([u, v])

        dfs(start_node)

        return path[::-1]