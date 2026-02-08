class Solution:
    def equationsPossible(self, equations: List[str]) -> bool:
        parent = {}

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            rootX = find(x)
            rootY = find(y)
            if rootX != rootY:
                parent[rootY] = rootX

        for eq in equations:
            if eq[1] == '=':
                if eq[0] not in parent:
                    parent[eq[0]] = eq[0]
                if eq[3] not in parent:
                    parent[eq[3]] = eq[3]
                union(eq[0], eq[3])

        for eq in equations:
            if eq[1] == '!':
                if eq[0] in parent and eq[3] in parent and find(eq[0]) == find(eq[3]):
                    return False

        return True