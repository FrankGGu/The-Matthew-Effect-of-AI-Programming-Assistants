class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.num_components = n

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)
        if root_i != root_j:
            self.parent[root_i] = root_j
            self.num_components -= 1
            return True
        return False

class Solution:
    def removeStones(self, stones: list[list[int]]) -> int:
        n = len(stones)
        dsu = DSU(n)

        for i in range(n):
            for j in range(i + 1, n):
                if stones[i][0] == stones[j][0] or stones[i][1] == stones[j][1]:
                    dsu.union(i, j)

        return n - dsu.num_components