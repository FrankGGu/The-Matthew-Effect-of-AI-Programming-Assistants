class Solution:
    def findRedundantEdge(self, edges: List[List[int]]) -> List[int]:
        parent = {}

        def find(node):
            if parent[node] != node:
                parent[node] = find(parent[node])
            return parent[node]

        def union(node1, node2):
            root1 = find(node1)
            root2 = find(node2)
            if root1 != root2:
                parent[root1] = root2
                return True
            return False

        for u, v in edges:
            if u not in parent:
                parent[u] = u
            if v not in parent:
                parent[v] = v

            if not union(u, v):
                return [u, v]