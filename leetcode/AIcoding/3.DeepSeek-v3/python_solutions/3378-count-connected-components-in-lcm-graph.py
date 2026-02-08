import math

class Solution:
    def countComponents(self, n: int, edges: List[List[int]]) -> int:
        parent = [i for i in range(n + 1)]

        def find(u):
            while parent[u] != u:
                parent[u] = parent[parent[u]]
                u = parent[u]
            return u

        def union(u, v):
            u_root = find(u)
            v_root = find(v)
            if u_root != v_root:
                parent[v_root] = u_root

        for u, v in edges:
            union(u, v)

        components = set()
        for i in range(1, n + 1):
            components.add(find(i))

        return len(components)