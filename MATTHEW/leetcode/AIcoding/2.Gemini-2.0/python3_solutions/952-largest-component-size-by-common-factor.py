class DSU:
    def __init__(self, N):
        self.parent = list(range(N))

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        rootX = self.find(x)
        rootY = self.find(y)
        if rootX != rootY:
            self.parent[rootX] = rootY

class Solution:
    def largestComponentSize(self, A: list[int]) -> int:
        N = len(A)
        dsu = DSU(N)

        factor_map = {}

        for i, num in enumerate(A):
            for factor in range(2, int(num**0.5) + 1):
                if num % factor == 0:
                    if factor in factor_map:
                        dsu.union(i, factor_map[factor])
                    else:
                        factor_map[factor] = i

                    other_factor = num // factor
                    if other_factor in factor_map:
                        dsu.union(i, factor_map[other_factor])
                    else:
                        factor_map[other_factor] = i

            if num > 1:
                if num in factor_map:
                    dsu.union(i, factor_map[num])
                else:
                    factor_map[num] = i

        counts = {}
        for i in range(N):
            root = dsu.find(i)
            counts[root] = counts.get(root, 0) + 1

        return max(counts.values()) if counts else 0