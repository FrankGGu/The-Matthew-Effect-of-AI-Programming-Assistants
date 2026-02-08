class Solution:
    def areConnected(self, n: int, threshold: int, queries: List[List[int]]) -> List[bool]:
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

        for z in range(threshold + 1, n + 1):
            for multiple in range(2 * z, n + 1, z):
                union(z, multiple)

        res = []
        for a, b in queries:
            res.append(find(a) == find(b))
        return res