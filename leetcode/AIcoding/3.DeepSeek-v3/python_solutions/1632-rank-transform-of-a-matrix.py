class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size))

    def find(self, x):
        while self.parent[x] != x:
            self.parent[x] = self.parent[self.parent[x]]
            x = self.parent[x]
        return x

    def union(self, x, y):
        px = self.find(x)
        py = self.find(y)
        if px != py:
            self.parent[py] = px

class Solution:
    def matrixRankTransform(self, matrix: List[List[int]]) -> List[List[int]]:
        m, n = len(matrix), len(matrix[0])
        rank = [0] * (m + n)
        d = defaultdict(list)

        for i in range(m):
            for j in range(n):
                d[matrix[i][j]].append((i, j))

        for val in sorted(d):
            uf = UnionFind(m + n)
            for i, j in d[val]:
                uf.union(i, j + m)

            groups = defaultdict(list)
            for i, j in d[val]:
                root = uf.find(i)
                groups[root].append((i, j))

            for group in groups.values():
                max_rank = 0
                for i, j in group:
                    max_rank = max(max_rank, rank[i], rank[j + m])
                new_rank = max_rank + 1
                for i, j in group:
                    rank[i] = rank[j + m] = new_rank

        result = [[0] * n for _ in range(m)]
        for i in range(m):
            for j in range(n):
                result[i][j] = rank[i]

        return result