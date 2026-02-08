class Solution:
    def smallestEquivalentString(self, s1: str, s2: str, baseStr: str) -> str:
        parent = {chr(ord('a') + i): chr(ord('a') + i) for i in range(26)}

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            root_x = find(x)
            root_y = find(y)
            if root_x != root_y:
                if root_x < root_y:
                    parent[root_y] = root_x
                else:
                    parent[root_x] = root_y

        for i in range(len(s1)):
            union(s1[i], s2[i])

        result = ""
        for char in baseStr:
            result += find(char)

        return result