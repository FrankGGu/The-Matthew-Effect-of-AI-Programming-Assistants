class Solution:
    def makeConnected(self, n: int, connections: List[List[int]]) -> int:
        if len(connections) < n - 1:
            return -1

        parent = [i for i in range(n)]

        def find(u):
            while parent[u] != u:
                parent[u] = parent[parent[u]]
                u = parent[u]
            return u

        def union(u, v):
            u_root = find(u)
            v_root = find(v)
            if u_root == v_root:
                return
            parent[v_root] = u_root

        for u, v in connections:
            union(u, v)

        components = set()
        for i in range(n):
            components.add(find(i))

        return len(components) - 1