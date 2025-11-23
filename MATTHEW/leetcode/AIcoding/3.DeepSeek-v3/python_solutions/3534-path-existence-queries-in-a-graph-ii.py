class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size))
        self.rank = [0] * size

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        x_root = self.find(x)
        y_root = self.find(y)
        if x_root == y_root:
            return
        if self.rank[x_root] < self.rank[y_root]:
            self.parent[x_root] = y_root
        else:
            self.parent[y_root] = x_root
            if self.rank[x_root] == self.rank[y_root]:
                self.rank[x_root] += 1

class DistanceLimitedPathsExist:

    def __init__(self, n: int, edgeList: List[List[int]]):
        self.ufs = []
        edgeList.sort(key=lambda x: x[2])
        self.sorted_edges = edgeList
        self.max_limits = []
        self.build_ufs(n)

    def build_ufs(self, n):
        uf = UnionFind(n)
        i = 0
        m = len(self.sorted_edges)
        prev_limit = 0
        for limit in sorted({e[2] for e in self.sorted_edges}):
            while i < m and self.sorted_edges[i][2] < limit:
                u, v, _ = self.sorted_edges[i]
                uf.union(u, v)
                i += 1
            new_uf = UnionFind(n)
            new_uf.parent = uf.parent.copy()
            new_uf.rank = uf.rank.copy()
            self.ufs.append(new_uf)
            self.max_limits.append(limit)
            prev_limit = limit

    def query(self, p: int, q: int, limit: int) -> bool:
        left, right = 0, len(self.max_limits)
        while left < right:
            mid = (left + right) // 2
            if self.max_limits[mid] < limit:
                left = mid + 1
            else:
                right = mid
        if left == 0:
            return False
        uf = self.ufs[left - 1]
        return uf.find(p) == uf.find(q)