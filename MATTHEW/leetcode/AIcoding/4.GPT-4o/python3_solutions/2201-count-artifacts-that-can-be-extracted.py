class Solution:
    def countArtifacts(self, n: int, artifacts: List[List[int]]) -> int:
        parent = list(range(n))

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            rootX = find(x)
            rootY = find(y)
            if rootX != rootY:
                parent[rootY] = rootX

        for a1, a2 in artifacts:
            union(a1, a2)

        return len(set(find(i) for i in range(n)))