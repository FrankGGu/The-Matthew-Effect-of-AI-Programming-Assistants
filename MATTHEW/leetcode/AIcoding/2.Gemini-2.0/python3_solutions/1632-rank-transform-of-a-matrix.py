class Solution:
    def matrixRankTransform(self, matrix: List[List[int]]) -> List[List[int]]:
        m, n = len(matrix), len(matrix[0])
        ranks = [0] * (m + n)
        pos = defaultdict(list)

        for i in range(m):
            for j in range(n):
                pos[matrix[i][j]].append((i, j))

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            px, py = find(x), find(y)
            if px != py:
                parent[px] = py

        for num in sorted(pos.keys()):
            parent = list(range(m + n))
            rank = ranks[:]
            for i, j in pos[num]:
                union(i, m + j)
            for i, j in pos[num]:
                rank[i] = rank[m + j] = max(rank[find(i)] + 1, rank[i], rank[m + j])
            for i, j in pos[num]:
                ranks[i] = ranks[m + j] = matrix[i][j] = rank[find(i)]

        return matrix