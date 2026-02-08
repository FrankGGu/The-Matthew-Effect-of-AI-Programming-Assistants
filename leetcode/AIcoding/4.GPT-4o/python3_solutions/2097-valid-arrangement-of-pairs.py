class Solution:
    def validArrangement(self, pairs: List[List[int]]) -> List[List[int]]:
        from collections import defaultdict

        graph = defaultdict(list)
        in_degree = defaultdict(int)
        out_degree = defaultdict(int)

        for u, v in pairs:
            graph[u].append(v)
            out_degree[u] += 1
            in_degree[v] += 1

        start = None
        for u in out_degree:
            if out_degree[u] - in_degree[u] == 1:
                start = u
                break
        if start is None:
            start = pairs[0][0]

        path = []
        def dfs(u):
            while graph[u]:
                v = graph[u].pop()
                dfs(v)
            path.append(u)

        dfs(start)
        return [[path[i + 1], path[i]] for i in range(len(path) - 1)][::-1]