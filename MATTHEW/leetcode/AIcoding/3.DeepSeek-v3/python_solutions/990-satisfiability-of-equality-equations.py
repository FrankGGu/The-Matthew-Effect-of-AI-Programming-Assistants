class Solution:
    def equationsPossible(self, equations: List[str]) -> bool:
        parent = [i for i in range(26)]

        def find(u):
            while parent[u] != u:
                parent[u] = parent[parent[u]]
                u = parent[u]
            return u

        def union(u, v):
            root_u = find(u)
            root_v = find(v)
            if root_u != root_v:
                parent[root_v] = root_u

        for eq in equations:
            if eq[1] == '=':
                u = ord(eq[0]) - ord('a')
                v = ord(eq[3]) - ord('a')
                union(u, v)

        for eq in equations:
            if eq[1] == '!':
                u = ord(eq[0]) - ord('a')
                v = ord(eq[3]) - ord('a')
                if find(u) == find(v):
                    return False

        return True