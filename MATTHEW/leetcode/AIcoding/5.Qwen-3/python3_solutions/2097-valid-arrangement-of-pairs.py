class Solution:
    def validArrangement(self, pairs: List[List[int]]) -> List[int]:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        in_degree = defaultdict(int)
        out_degree = defaultdict(int)

        for u, v in pairs:
            graph[u].append(v)
            out_degree[u] += 1
            in_degree[v] += 1

        start_node = pairs[0][0]
        for node in out_degree:
            if out_degree[node] - in_degree[node] == 1:
                start_node = node
                break

        result = []

        def dfs(u):
            while graph[u]:
                v = graph[u].pop()
                dfs(v)
                result.append([u, v])

        dfs(start_node)

        return result[::-1]