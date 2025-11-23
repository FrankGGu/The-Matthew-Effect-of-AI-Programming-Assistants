class Solution:
    def equationsPossible(self, equations: list[str]) -> bool:
        parent = list(range(26))

        def find(i):
            if parent[i] == i:
                return i
            parent[i] = find(parent[i])
            return parent[i]

        def union(i, j):
            root_i = find(i)
            root_j = find(j)
            if root_i != root_j:
                parent[root_i] = root_j

        for eq in equations:
            if eq[1] == '=':
                var1 = ord(eq[0]) - ord('a')
                var2 = ord(eq[3]) - ord('a')
                union(var1, var2)

        for eq in equations:
            if eq[1] == '!':
                var1 = ord(eq[0]) - ord('a')
                var2 = ord(eq[3]) - ord('a')
                if find(var1) == find(var2):
                    return False

        return True