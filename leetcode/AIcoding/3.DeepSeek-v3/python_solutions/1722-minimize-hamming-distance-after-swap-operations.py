class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size))

    def find(self, x):
        while self.parent[x] != x:
            self.parent[x] = self.parent[self.parent[x]]
            x = self.parent[x]
        return x

    def union(self, x, y):
        fx = self.find(x)
        fy = self.find(y)
        if fx != fy:
            self.parent[fy] = fx

class Solution:
    def minimumHammingDistance(self, source: List[int], target: List[int], allowedSwaps: List[List[int]]) -> int:
        n = len(source)
        uf = UnionFind(n)
        for a, b in allowedSwaps:
            uf.union(a, b)

        groups = defaultdict(list)
        for i in range(n):
            groups[uf.find(i)].append(i)

        res = 0
        for group in groups.values():
            freq = defaultdict(int)
            for idx in group:
                freq[source[idx]] += 1
            for idx in group:
                if freq[target[idx]] > 0:
                    freq[target[idx]] -= 1
                else:
                    res += 1
        return res