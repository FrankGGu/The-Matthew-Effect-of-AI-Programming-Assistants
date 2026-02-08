class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        rootX = self.find(x)
        rootY = self.find(y)
        if rootX != rootY:
            if self.rank[rootX] < self.rank[rootY]:
                self.parent[rootX] = rootY
            elif self.rank[rootX] > self.rank[rootY]:
                self.parent[rootY] = rootX
            else:
                self.parent[rootY] = rootX
                self.rank[rootX] += 1
            return True
        return False

class Solution:
    def minCost(self, n: int, edges: list[list[int]], max_edges: int) -> int:
        edges.sort(key=lambda x: x[2])
        dsu = DSU(n)
        cost = 0
        count = 0
        for u, v, w in edges:
            if dsu.union(u, v):
                cost += w
                count += 1
                if count == n - 1 or count == max_edges:
                    break
        if count < max_edges:
            return -1

        dsu = DSU(n)
        count = 0
        for u, v, w in edges:
            if dsu.union(u, v):
                count += 1

        if count != n - 1:
            return -1

        l, r = 0, 10**9
        ans = -1
        while l <= r:
            mid = (l + r) // 2
            dsu = DSU(n)
            count = 0
            num_edges = 0
            for u, v, w in edges:
                if w <= mid and dsu.union(u, v):
                    num_edges += 1
                    count += 1
                    if count == max_edges:
                        break

            if count < max_edges:
                l = mid + 1
                continue

            dsu = DSU(n)
            connected = 0
            for u, v, w in edges:
                if w <= mid and dsu.union(u, v):
                    connected += 1

            for u, v, w in edges:
                if w > mid and dsu.union(u,v):
                    connected += 1

            if connected == n - 1:
                ans = mid
                r = mid - 1
            else:
                l = mid + 1
        return ans