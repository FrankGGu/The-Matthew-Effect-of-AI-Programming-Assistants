class Solution:
    def countCompleteComponents(self, n: int, edges: List[List[int]]) -> int:
        parent = [i for i in range(n)]
        size = [1] * n
        edge_count = [0] * n

        def find(u):
            while parent[u] != u:
                parent[u] = parent[parent[u]]
                u = parent[u]
            return u

        for u, v in edges:
            root_u = find(u)
            root_v = find(v)
            if root_u != root_v:
                if size[root_u] < size[root_v]:
                    root_u, root_v = root_v, root_u
                parent[root_v] = root_u
                size[root_u] += size[root_v]
                edge_count[root_u] += edge_count[root_v]
            edge_count[root_u] += 1

        roots = set()
        for i in range(n):
            roots.add(find(i))

        complete = 0
        for root in roots:
            m = size[root]
            if edge_count[root] == m * (m - 1) // 2:
                complete += 1

        return complete