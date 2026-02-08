class Solution:
    def smallestEquivalentString(self, s1: str, s2: str, baseStr: str) -> str:
        parent = {}

        def find(u):
            if u not in parent:
                parent[u] = u
            while parent[u] != u:
                parent[u] = parent[parent[u]]
                u = parent[u]
            return u

        def union(u, v):
            root_u = find(u)
            root_v = find(v)
            if root_u != root_v:
                if root_u < root_v:
                    parent[root_v] = root_u
                else:
                    parent[root_u] = root_v

        for u, v in zip(s1, s2):
            union(u, v)

        result = []
        for c in baseStr:
            result.append(find(c))
        return ''.join(result)