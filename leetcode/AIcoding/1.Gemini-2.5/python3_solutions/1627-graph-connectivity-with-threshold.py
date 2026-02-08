class DSU:
    def __init__(self, n):
        self.parent = list(range(n))

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)
        if root_i != root_j:
            self.parent[root_j] = root_i
            return True
        return False

class Solution:
    def areConnected(self, n: int, threshold: int, queries: list[list[int]]) -> list[bool]:
        dsu = DSU(n + 1)

        for k in range(threshold + 1, n + 1):
            for multiple_of_k in range(2 * k, n + 1, k):
                dsu.union(k, multiple_of_k)

        results = []
        for city1, city2 in queries:
            results.append(dsu.find(city1) == dsu.find(city2))

        return results