class Solution:
    def removeMaxEdges(self, n: int, edges: List[List[int]]) -> int:
        def find(parent, x):
            if parent[x] != x:
                parent[x] = find(parent, parent[x])
            return parent[x]

        def union(parent, rank, x, y):
            x_root = find(parent, x)
            y_root = find(parent, y)
            if x_root == y_root:
                return False
            if rank[x_root] < rank[y_root]:
                parent[x_root] = y_root
            else:
                parent[y_root] = x_root
                if rank[x_root] == rank[y_root]:
                    rank[x_root] += 1
            return True

        parent1 = list(range(n + 1))
        rank1 = [1] * (n + 1)
        parent2 = list(range(n + 1))
        rank2 = [1] * (n + 1)

        edges.sort(reverse=True)
        count = 0

        for t, u, v in edges:
            if t == 1:
                if not union(parent1, rank1, u, v):
                    count += 1
            else:
                if not union(parent2, rank2, u, v):
                    count += 1

        for t, u, v in edges:
            if t == 1:
                if not union(parent1, rank1, u, v):
                    count += 1
            else:
                if not union(parent2, rank2, u, v):
                    count += 1

        root1 = find(parent1, 1)
        for i in range(2, n + 1):
            if find(parent1, i) != root1:
                return -1

        root2 = find(parent2, 1)
        for i in range(2, n + 1):
            if find(parent2, i) != root2:
                return -1

        return count