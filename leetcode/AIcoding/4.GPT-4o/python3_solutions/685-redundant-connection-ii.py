class Solution:
    def findRedundantDirectedConnection(self, edges: List[List[int]]) -> List[int]:
        parent = {}
        degree = {}

        for u, v in edges:
            if v in parent:
                degree[v] += 1
            else:
                degree[v] = 1
            parent[v] = u

        def find(x):
            if x != parent.get(x, x):
                parent[x] = find(parent[x])
            return parent.get(x, x)

        for u, v in edges:
            if v in parent and parent[v] != u:
                if degree[v] == 1:
                    return [u, v]
                else:
                    parent[v] = u
                    if find(u) == find(v):
                        return [u, v]
            else:
                parent[v] = u

        return []