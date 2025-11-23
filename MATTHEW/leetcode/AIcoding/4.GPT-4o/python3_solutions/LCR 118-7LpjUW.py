class Solution:
    def findRedundantDirectedConnection(self, edges: List[List[int]]) -> List[int]:
        parent = {}
        candidates = []

        def find(node):
            if node != parent.setdefault(node, node):
                parent[node] = find(parent[node])
            return parent[node]

        for u, v in edges:
            if v in parent:
                candidates.append((u, v))
                continue
            parent[v] = u

        for u, v in edges:
            if v in parent and (u, v) in candidates:
                continue
            if find(u) == find(v):
                return [u, v]
            parent[find(u)] = find(v)

        return candidates[-1]