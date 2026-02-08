from typing import List

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
    def minimumCost(self, n: int, edges: List[List[int]], queries: List[List[int]]) -> List[int]:
        ans = [0] * len(queries)

        for i in range(len(queries)):
            s, t = queries[i]
            if s == t:
                ans[i] = (1 << 30) - 1

        for b in range(30):
            dsu = DSU(n)
            for u, v, w in edges:
                if (w >> b) & 1:
                    dsu.union(u, v)

            for i in range(len(queries)):
                s, t = queries[i]
                if s == t:
                    continue
                if dsu.find(s) == dsu.find(t):
                    ans[i] |= (1 << b)

        all_edges_dsu = DSU(n)
        for u, v, w in edges:
            all_edges_dsu.union(u, v)

        for i in range(len(queries)):
            s, t = queries[i]
            if s == t:
                continue
            if ans[i] == 0:
                if all_edges_dsu.find(s) != all_edges_dsu.find(t):
                    ans[i] = -1

        return ans