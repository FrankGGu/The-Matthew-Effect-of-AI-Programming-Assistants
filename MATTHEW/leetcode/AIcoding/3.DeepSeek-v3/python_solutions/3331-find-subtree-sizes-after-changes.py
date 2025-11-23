class Solution:
    def subtreeSizeAfterChanges(self, n: int, edges: List[List[int]], changes: List[List[int]]) -> List[int]:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        parent = [0] * n
        size = [1] * n

        stack = [(0, None, False)]
        while stack:
            node, p, visited = stack.pop()
            if not visited:
                parent[node] = p
                stack.append((node, p, True))
                for neighbor in graph[node]:
                    if neighbor != p:
                        stack.append((neighbor, node, False))
            else:
                for neighbor in graph[node]:
                    if neighbor != p:
                        size[node] += size[neighbor]

        res = []
        for u, v in changes:
            if parent[u] == v:
                u, v = v, u
            original_size_u = size[u]
            original_size_v = size[v]

            size[u] -= size[v]
            size[v] = original_size_u

            parent[u], parent[v] = parent[v], parent[u]

            res.append(size[0])

        return res